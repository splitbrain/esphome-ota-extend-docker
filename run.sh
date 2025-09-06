#!/bin/bash


NAME=$(basename "$(ls config/*.yaml 2>/dev/null | head -n1)" .yaml)


if [[ -z "$NAME" ]]; then
    echo "Couldn't find the yaml configuration"
    exit 1
fi

while true; do
    echo "Please select an option:"
    echo "1) Validate $NAME.yaml"
    echo "2) Compile $NAME.yaml"
    echo "3) Upload Factory OTA for $NAME.yaml"
    echo "X) Exit"
    read -p "Enter your choice: " choice

    case "$choice" in
        1)
            esphome config config/$NAME.yaml
            ;;
        2)
            rm -r config/.esphome
            esphome compile config/$NAME.yaml && \
            cp config/.esphome/build/$NAME/.pioenvs/$NAME/firmware.bin config/$NAME.bin && \
            echo "Manually upload the $NAME.bin file as new OTA Firmware"
            ;;
        3)
            esphome -v upload-factory-ota config/$NAME.yaml
            ;;
        [Xx])
            echo "Exiting."
            break
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
    echo    # Blank line for readability
done
