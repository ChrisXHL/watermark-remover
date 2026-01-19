#!/bin/bash

# ========================================
# 智能去水印工具 - 自动化部署脚本
# ========================================

set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_DIR"

echo "🚀 开始部署智能去水印工具..."
echo "📁 项目目录: $PROJECT_DIR"

# 检查必要的文件
echo "✅ 检查核心文件..."
for file in index.html vercel.json package.json; do
    if [ -f "$file" ]; then
        echo "  ✓ $file 存在"
    else
        echo "  ✗ $file 缺失!"
        exit 1
    fi
done

# 初始化 git（如果需要）
if [ ! -d ".git" ]; then
    echo "📦 初始化 Git 仓库..."
    git init
    git add .
    git commit -m "Initial commit: Smart watermark remover $(date +%Y-%m-%d)"
fi

# 选择部署平台
deploy_platform() {
    echo ""
    echo "请选择部署平台:"
    echo "1) Vercel (推荐)"
    echo "2) Netlify"
    echo "3) GitHub Pages"
    echo "4) 本地预览"
    echo "5) 全部部署"
    echo ""
    read -p "请输入选项 (1-5): " choice
    
    case $choice in
        1) deploy_vercel ;;
        2) deploy_netlify ;;
        3) deploy_github_pages ;;
        4) local_preview ;;
        5) 
            deploy_vercel
            deploy_netlify
            deploy_github_pages
            ;;
        *) echo "无效选项"; exit 1 ;;
    esac
}

deploy_vercel() {
    echo ""
    echo "🔵 部署到 Vercel..."
    
    if ! command -v vercel &> /dev/null; then
        echo "📦 安装 Vercel CLI..."
        npm install -g vercel
    fi
    
    echo "📡 执行: npx vercel --prod"
    npx vercel --prod --token="${VERCEL_TOKEN:-}" || {
        echo "⚠️  Vercel 部署需要登录"
        echo "💡 请设置环境变量 VERCEL_TOKEN 或运行: vercel login"
        echo "   获取 Token: https://vercel.com/account/tokens"
    }
}

deploy_netlify() {
    echo ""
    echo "🟣 部署到 Netlify..."
    
    if ! command -v netlify &> /dev/null; then
        echo "📦 安装 Netlify CLI..."
        npm install -g netlify-cli
    fi
    
    echo "📡 执行: netlify deploy"
    npx netlify deploy --dir=. --prod --auth="${NETLIFY_AUTH_TOKEN:-}" || {
        echo "⚠️  Netlify 部署需要登录"
        echo "💡 请设置环境变量 NETLIFY_AUTH_TOKEN 或运行: netlify login"
    }
}

deploy_github_pages() {
    echo ""
    echo "🟢 部署到 GitHub Pages..."
    
    if [ -z "$GITHUB_TOKEN" ]; then
        echo "⚠️  需要设置 GITHUB_TOKEN 环境变量"
        echo "💡 在 GitHub Settings → Developer settings → Personal access tokens 创建"
        return
    fi
    
    REPO_URL=$(git remote get-url origin 2>/dev/null || echo "")
    if [ -z "$REPO_URL" ]; then
        echo "⚠️  未找到 Git 远程仓库"
        echo "💡 请先推送到 GitHub"
        return
    fi
    
    echo "📦 构建并推送到 gh-pages 分支..."
    npm run build 2>/dev/null || true
    git checkout -b gh-pages
    git add -f .
    git commit -m "Deploy to GitHub Pages $(date +%Y-%m-%d)"
    git push -f origin gh-pages
    git checkout -
    
    echo "✅ 部署完成!"
    echo "🌐 访问: https://$(echo $REPO_URL | sed 's/.*github.com\///' | sed 's/\.git//' | tr '/' '\n' | head -2 | tr '\n' '.')github.io/$(echo $REPO_URL | sed 's/.*github.com\///' | sed 's/\.git//' | tr '/' '\n' | tail -1)"
}

local_preview() {
    echo ""
    echo "🔵 本地预览..."
    
    if command -v serve &> /dev/null; then
        serve . -l 3000
    elif command -v python3 &> /dev/null; then
        python3 -m http.server 3000
    else
        echo "⚠️  无法启动本地服务器"
        echo "💡 请安装 serve: npm install -g serve"
    fi
}

# 自动部署模式（无交互）
auto_deploy() {
    echo ""
    echo "🤖 自动部署模式..."
    
    if [ -n "$VERCEL_TOKEN" ]; then
        deploy_vercel
    fi
    
    if [ -n "$NETLIFY_AUTH_TOKEN" ]; then
        deploy_netlify
    fi
}

# 主逻辑
if [ "$1" = "--auto" ]; then
    auto_deploy
else
    deploy_platform
fi

echo ""
echo "✅ 部署脚本执行完成!"
