#!/bin/bash

# 函数：安装 GaiaNet 节点
function install_node() {
    echo "正在安装 GaiaNet 节点..."
    echo "请稍候..."

    # 下载并运行 GaiaNet 的 install.sh 脚本
    curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash

    # 检查安装结果
    if [ $? -ne 0 ]; then
        echo "安装过程中出现错误，请检查网络连接或稍后重试。"
        exit 1
    fi

    echo "GaiaNet 节点安装成功！"
}
# 启动 GaiaNet 节点
echo "正在启动 GaiaNet 节点..."

# 执行 gaianet start 命令
gaianet start

# 检查 gaianet start 的退出码
if [ $? -ne 0 ]; then
    echo "启动节点过程中出现错误，请检查相关配置或稍后重试。"
else
    echo "GaiaNet 节点启动成功！"
fi


# 获取并打印官方节点地址
echo "================================================================"
echo "官方节点地址："
gaianet info

# 函数：卸载 GaiaNet 节点
function uninstall_node() {
    echo "正在卸载 GaiaNet 节点..."
    echo "请稍候..."

    # 停止并删除 GaiaNet 节点容器
    docker stop gaianet-node
    docker rm gaianet-node

    # 删除 GaiaNet 节点数据和配置
    sudo rm -rf ~/.gaianet

    echo "GaiaNet 节点卸载完成。"
}

# 函数：显示主菜单
function main_menu() {
    while true; do
        clear
        echo "GaiaNet 一键安装脚本"
        echo "======================="
        echo "1. 安装 GaiaNet 节点"
        echo "2. 卸载 GaiaNet 节点"
        echo "3. 退出脚本"
        echo "======================="
        read -p "请选择操作（输入对应数字）：" OPTION

        case $OPTION in
            1) install_node ;;
            2) uninstall_node ;;
            3) echo "退出脚本。"; exit 0 ;;
            *) echo "无效选项，请重新输入。" ;;
        esac

        read -n 1 -s -r -p "按任意键返回主菜单..."
    done
}

# 执行主菜单函数
main_menu
