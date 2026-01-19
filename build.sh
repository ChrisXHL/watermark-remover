#!/bin/bash

# ========================================
# 生产环境构建脚本
# ========================================

set -e

echo "🔧 开始构建生产版本..."

# 验证 HTML 完整性
if ! grep -q "</html>" index.html; then
    echo "❌ 错误: index.html 文件不完整"
    exit 1
fi

# 验证 JavaScript 语法（简单检查）
if ! grep -q "</script>" index.html; then
    echo "❌ 错误: JavaScript 代码不完整"
    exit 1
fi

# 检查文件大小
FILE_SIZE=$(wc -c < index.html)
if [ "$FILE_SIZE" -lt 10000 ]; then
    echo "⚠️  警告: index.html 文件较小 ($FILE_SIZE bytes)，可能内容不完整"
fi

echo "✅ 代码验证通过"
echo "📦 文件大小: $FILE_SIZE bytes"

# 验证 vercel.json 配置
if ! grep -q '"outputDirectory"' vercel.json; then
    echo "❌ 错误: vercel.json 配置不完整"
    exit 1
fi

echo "✅ Vercel 配置验证通过"

# 清理临时文件
rm -rf .cache dist build 2>/dev/null || true

echo "✅ 构建准备完成!"
echo ""
echo "📋 项目结构:"
ls -lh

echo ""
echo "🚀 可以执行以下命令进行部署:"
echo "   ./deploy.sh"
echo ""
echo "🌐 或设置环境变量后自动部署:"
echo "   export VERCEL_TOKEN=your_token"
echo "   ./deploy.sh --auto"
