#!/bin/bash

# 检查是否以root用户运行脚本
if [[ $EUID -ne 0 ]]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

# 函数：安装 GaiaNet 节点
function install_node() {
    echo "开始安装 GaiaNet 节点..."
    curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash

    echo "GaiaNet 节点安装完成。"
    
    # 使 gaianet CLI 工具在当前 shell 中可用
    source /root/.bashrc

    # 初始化 GaiaNet 节点
    gaianet init

    # 启动 GaiaNet 节点
    gaianet start

    echo "GaiaNet 节点已启动。"
    echo "节点安装和启动完成。"
}

# 函数：查看节点信息
function view_node_info() {
    echo "获取节点信息..."
    source /root/.bashrc
    gaianet info
    read -n 1 -s -r -p "按任意键返回主菜单..."
}

# 函数：显示主菜单
function main_menu() {
    while true; do
        clear  # 清屏
        echo "脚本由推特 @ferdie_jhovie 制作，免费开源，请勿相信收费"
        echo "GaiaNet 一键安装脚本"
        echo "======================="
        echo "1. 安装 GaiaNet 节点"
        echo "2. 查看节点信息"
        echo "3. 退出脚本"
        echo "======================="
        read -p "请选择操作（输入对应数字）：" OPTION

        case $OPTION in
            1)
                install_node
                read -n 1 -s -r -p "按任意键返回主菜单..."
                ;;
            2)
                view_node_info
                ;;
            3)
                echo "退出脚本。"
                exit
                ;;
            *)
                echo "无效的选项，请重新选择。"
                read -n 1 -s -r -p "按任意键返回主菜单..."
                ;;
        esac
    done
}

# 运行主菜单
main_menu
