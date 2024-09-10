# SimplePyLauncher with build.zig

PC 目录的代码源自：https://github.com/pypa/distlib/tree/0.3.8/PC

## 构建

```sh
zig build --release=small
```

## 使用

1. 将 python 脚本改名为 xxx-script.py。需要确保后缀为 `-script.py`
2. 在 xxx-script.py 增加 `#!/path/to/python.exe` 一行
3. 将 pystart.exe 改名为 xxx.exe
4. 执行 xxx.exe
