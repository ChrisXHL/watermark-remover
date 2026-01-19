# 🖼️ 智能去水印工具

一个基于AI的智能图像水印去除工具，完全在浏览器端运行，保护隐私。

## ✨ 功能特点

- **自动去水印** - 智能检测并去除图片中的水印
- **手动去水印** - 用户可以框选需要去除的区域
- **去噪功能** - 去除图片噪点和压缩伪影
- **实时预览** - 对比原图和处理结果
- **纯前端实现** - 无需后端，保护隐私
- **免费部署** - 可部署到任何静态托管平台

## 🚀 快速部署

### 方式一：Vercel（推荐）

```bash
# 1. 安装 Vercel CLI
npm install -g vercel

# 2. 登录 Vercel
vercel login

# 3. 部署项目
cd watermark-remover
vercel --prod
```

或者使用 GitHub：
1. 将项目推送到 GitHub 仓库
2. 访问 [Vercel](https://vercel.com)
3. 点击 "Import Project" 并选择你的仓库

### 方式二：Netlify

```bash
# 1. 安装 Netlify CLI
npm install -g netlify-cli

# 2. 登录 Netlify
netlify login

# 3. 部署项目
cd watermark-remover
netlify deploy --dir=. --prod
```

或者使用 GitHub：
1. 将项目推送到 GitHub 仓库
2. 访问 [Netlify](https://netlify.com)
3. 点击 "Add new site" → "Import an existing project"

### 方式三：GitHub Pages

```bash
# 1. 创建 GitHub 仓库并推送
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/你的用户名/watermark-remover.git
git push -u origin main

# 2. 在仓库设置中启用 GitHub Pages
# Settings → Pages → 选择 main branch → Save
```

### 方式四：本地运行

```bash
# 使用 serve
npx serve .

# 或者使用 Python
python -m http.server 8000
```

然后访问 http://localhost:3000 或 http://localhost:8000

## 📖 使用说明

1. **上传图片** - 点击上传区域或拖拽图片
2. **选择模式**：
   - **自动模式** - 系统自动检测水印区域
   - **手动模式** - 在图片上框选需要去除的区域
   - **去噪模式** - 去除图片噪点
3. **调整参数** - 根据需要调整敏感度或画笔大小
4. **开始处理** - 点击"智能处理"按钮
5. **下载结果** - 处理完成后点击"下载结果"

## 🛠️ 技术栈

- 纯原生 HTML/CSS/JavaScript
- Canvas API 进行图像处理
- 无需任何外部依赖
- 完全在浏览器端运行

## 📁 项目结构

```
watermark-remover/
├── index.html      # 主页面
├── vercel.json     # Vercel 配置
├── package.json    # 项目配置
└── README.md       # 说明文档
```

## 🌐 访问地址

部署成功后，你的工具将可以通过以下地址访问：

- **Vercel**: https://your-project.vercel.app
- **Netlify**: https://your-project.netlify.app
- **GitHub Pages**: https://你的用户名.github.io/watermark-remover

## 📝 许可证

MIT License

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！
