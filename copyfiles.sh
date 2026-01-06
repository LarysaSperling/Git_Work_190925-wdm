for file in "$source_directory"/*."$file_extension"; do
    filename=$(basename "$file")
    name_without_ext="${filename%.*}"

    cp "$file" "$target_directory/$name_without_ext.$new_file_extension"

    echo "Скопирован файл: $filename -> $name_without_ext.$new_file_extension"
done

