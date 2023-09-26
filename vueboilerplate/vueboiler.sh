#!/bin/bash
pwd
echo "Enter filename.."
read filename
touch src/components/$filename.vue
echo "

" >> src/components/$filename.vue
file_to_edit="src/components/$filename.vue"
content_to_insert="/bin/vueboilertemplate.txt"
line_number=1


if [ -f "$file_to_edit" ]; then
    # Check if the file exists
    if [ "$(wc -l < "$file_to_edit")" -ge "$line_number" ]; then
        # Check if the file has at least the specified number of lines
        sed -i "${line_number}r $content_to_insert" "$file_to_edit"
    else
        echo "Error: The file has fewer than $line_number lines."
    fi
else
    echo "Error: The file '$file_to_edit' does not exist."
fi