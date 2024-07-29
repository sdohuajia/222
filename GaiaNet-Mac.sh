#!/bin/bash

# 函数：安装 Docker（在 macOS 上一般直接安装 Docker Desktop，无需脚本安装）
function install_docker() {
    echo "请下载并安装 Docker Desktop https://www.docker.com/products/docker-desktop"
    echo "安装完成后，无需手动启动和启用 Docker 服务。"
}

# 函数：检查 Docker 是否已安装
function check_docker_installed() {
    if ! command -v docker &> /dev/null; then
        echo "未检测到 Docker 安装，请安装 Docker Desktop。"
        install_docker
    else
        echo "Docker 已安装，跳过安装步骤。"
    fi
}

# 函数：启动 GaiaNet 节点
function start_node() {
    echo "正在启动 GaiaNet 节点..."

    # 进入 GaiaNet 目录（请替换为实际的 gaianet 目录路径）
    cd /Users/YourUsername/path/to/gaianet  # 替换为实际的 gaianet 目录路径

    # 执行 gaianet start 命令
    ./gaianet start

    # 检查 gaianet start 的退出码
    if [ $? -ne 0 ]; then
        echo "启动节点过程中出现错误，请检查相关配置或稍后重试。"
    else
        echo "GaiaNet 节点启动成功！"
    fi
}

# 函数：卸载 GaiaNet 节点
function uninstall_node() {
    echo "正在卸载 GaiaNet 节点..."
    echo "请稍候..."

    # 停止 GaiaNet 节点（根据实际情况调整命令）
    ./gaianet stop
    ./gaianet rm

    # 删除 GaiaNet 节点数据和配置
    rm -rf ~/.gaianet

    echo "GaiaNet 节点卸载完成。"
}

# 函数：显示主菜单
function main_menu() {
    while true; do
        clear  # 清屏
        echo "GaiaNet 一键安装脚本"
        echo "======================="
        echo "1. 安装 GaiaNet 节点"
        echo "2. 启动 GaiaNet 节点"
        echo "3. 卸载 GaiaNet 节点"
        echo "4. GaiaNet 节点信息"
        echo "5. 退出脚本"
        echo "======================="
        read -p "请选择操作（输入对应数字）：" OPTION

        case $OPTION in
            1)
                install_node
                read -n 1 -s -r -p "按任意键返回主菜单..."
                ;;
            2)
                start_node
                read -n 1 -s -r -p "按任意键返回主菜单..."
                ;;
            3)
                uninstall_node
                read -n 1 -s -r -p "按任意键返回主菜单..."
                ;;
            4)
                gaianet_info
                read -n 1 -s -r -p "按任意键返回主菜单..."
                ;;
            5)
                echo "退出脚本。"
                exit 0
                ;;
            *)
                echo "无效选项，请重新输入。"
                ;;
        esac
    done
}

# 执行主菜单函数
main_menu
