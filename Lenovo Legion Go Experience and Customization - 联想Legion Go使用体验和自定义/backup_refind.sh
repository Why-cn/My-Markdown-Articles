#!/bin/bash

# 源目录
source_dir="/boot/efi/EFI/refind/"

# 目标 tar.gz 文件名
tar_file="refind_backup.tar.gz"

# 检查源目录是否存在
if [ ! -d "$source_dir" ]; then
  echo "错误：源目录 $source_dir 不存在。"
  exit 1
fi

# 检查目标 tar.gz 文件是否已存在，如果存在则备份旧文件
if [ -f "$tar_file" ]; then
  timestamp=$(date +%Y%m%d%H%M%S)
  old_tar_file="refind_backup_${timestamp}.tar.gz"
  echo "警告：目标文件 $tar_file 已存在，将其重命名为 $old_tar_file。"
  mv "$tar_file" "$old_tar_file"
fi

# 创建 tar.gz 压缩包
tar -czvf "$tar_file" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"

# 检查 tar 压缩是否成功
if [ $? -eq 0 ]; then
  echo "成功：已将 $source_dir 备份到 $tar_file，根目录为 $(basename "$source_dir")。"
else
  echo "错误：创建 tar 压缩包失败。"
  exit 1
fi

exit 0
