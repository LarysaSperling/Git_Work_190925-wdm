#!/bin/bash

# Запрос исходной и целевой директории у пользователя
while true; do
  read -p "Исходная директория: " source_directory
  if [ -z "$source_directory" ]; then
    echo "Пожалуйста, введите имя исходной директории."
  else
    break
  fi
done

while true; do
  read -p "Целевая директория: " target_directory
  if [ -z "$target_directory" ]; then
    echo "Пожалуйста, введите имя целевой директории."
  else
    break
  fi
done
# Запрос расширения файлов, которые нужно скопировать

read -p "Введите расширения файлов, которые нужно скопировать: " file_extension

while [[ $file_extension = "" ]]; do
    read -p "Некорректный ввод. Введите расширения еще раз: " file_extension
done

# Запросить новое расширение для файлов.
read -p "Введите новое расширения: " new_file_extension

# Проверка существования исходной директории и целевой директории
if [ ! -d "$source_directory" ]; then
echo  "Ошибка: исходная директория не существует или недоступна"
exit 1
fi
if [ ! -d "$target_directory" ]; then
echo "Целевая директория не существует. Создаю"
mkdir -p "$target_directory"
fi
echo "Проверка пройдена успешно"



# Проверка, есть ли файлы с указанным расширением в исходной директории

if ! find "$source_directory" -maxdepth 1 -type f -name "*.$file_extension" | grep -q .; then
echo "Ошибка: файлы с расширением .$file_extension не найдены"
 exit 1
fi
# Копирование файлов с указанным расширением в целевую директорию
for file in "$source_directory"/*."$file_extension"; do
    filename=$(basename "$file")
    name_without_ext="${filename%.*}"

    cp "$file" "$target_directory/$name_without_ext.$new_file_extension"

    echo "Скопирован файл: $filename -> $name_without_ext.$new_file_extension"
done

# Архивация исходных файлов.
# 7.Создание архива исходных файлов.
# Описание: Создать сжатый tar архив с исходными файлами.
# Действие: Архивируем файлы из исходной директории source_directory с расширением - file_extension
# Архив создается в целефой директории - target_directory
# Имя архива: old_files_"Текщая дата в формате Y-M-D".tar.gz
# Удалите файлы с расширением file_extension из исходной директории
current_date=$(date +"%Y-%m-%d")
archive_name="old_files_$current_date.tar.gz"

tar -czf "$target_directory/$archive_name" "$source_directory"/
