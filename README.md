# Enterprise Knowledge Base Management System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![AI Agent Compatible](https://img.shields.io/badge/AI%20Agent-Compatible-green.svg)](https://agentskills.io/)

一套企业级知识库管理系统，支持文档上传、语义搜索、RAG 问答和分布式部署。可作为独立系统使用，也可集成到各种 AI Agent 平台（如 Kiro IDE、Claude Code 等）。

## 🚀 特性

### 📚 kb-manager (知识库管理器)
- ✅ **文档上传与管理** - 支持 PDF、DOCX、TXT、Markdown 格式
- ✅ **智能分块处理** - 可配置的文档分块策略
- ✅ **语义搜索** - 基于向量相似度的高精度搜索
- ✅ **RAG 问答** - 结合检索和生成的智能问答
- ✅ **系统级数据管理** - 跨应用数据共享
- ✅ **多种嵌入模型** - 支持 DashScope、OpenAI 等

### 🔍 kb-reader (知识库查询器)
- ✅ **只读查询** - 安全的只读访问模式
- ✅ **轻量级设计** - 专注查询功能，最小化资源占用
- ✅ **多种搜索模式** - 语义搜索、关键词搜索、混合搜索
- ✅ **权限隔离** - 严格的只读权限，无法修改数据
- ✅ **分布式部署** - 可部署在不同应用或服务中

## 📁 项目结构

```
enterprise-kb-system/
├── kb-manager/           # 知识库管理器 (完整权限)
│   ├── src/             # 核心源代码
│   ├── main.py          # 主入口文件
│   ├── config.json      # 配置文件
│   ├── requirements.txt # 依赖列表
│   └── SKILL.md         # 技能定义文档
├── kb-reader/           # 知识库查询器 (只读权限)
│   ├── src/             # 核心源代码
│   ├── main.py          # 主入口文件
│   ├── config.json      # 配置文件
│   ├── requirements.txt # 依赖列表
│   └── SKILL.md         # 技能定义文档
└── README.md            # 项目说明文档
```

## 🛠️ 技术栈

- **向量数据库**: ChromaDB (本地存储，无需 Docker)
- **嵌入模型**: DashScope text-embedding-v3 (1024维) / OpenAI
- **文档处理**: PyPDF2, python-docx, markdown
- **搜索算法**: 余弦相似度 + 关键词匹配
- **API 框架**: OpenAI 兼容接口

## 🚀 快速开始

### 1. 环境要求

- Python 3.8+
- DashScope API 密钥 或 OpenAI API 密钥

### 2. 安装依赖

```bash
# 安装 kb-manager 依赖
cd kb-manager
pip install -r requirements.txt

# 安装 kb-reader 依赖  
cd ../kb-reader
pip install -r requirements.txt
```

### 3. 配置 API 密钥

```bash
# DashScope (推荐)
export DASHSCOPE_API_KEY='your-dashscope-api-key'

# 或者 OpenAI
export OPENAI_API_KEY='your-openai-api-key'
```

### 4. 初始化系统

```bash
# 使用 kb-manager 初始化系统环境
cd kb-manager
python main.py setup
```

### 5. 上传文档

```bash
# 上传文档到知识库
python main.py upload /path/to/document.pdf "文档名称"
```

### 6. 查询测试

```bash
# 使用 kb-reader 查询
cd ../kb-reader
python main.py query "你的问题"
```

## 📋 使用方式

### 作为独立系统

```bash
# 直接使用命令行
cd kb-manager
python main.py upload document.pdf "文档名称"
python main.py query "你的问题"

cd ../kb-reader  
python main.py query "你的问题"
python main.py stats
```

### 集成到 AI Agent 平台

#### Kiro IDE

1. **复制到 Kiro Skills 目录**:
   ```bash
   # 项目级别
   cp -r kb-manager /path/to/your/project/.kiro/skills/
   cp -r kb-reader /path/to/your/project/.kiro/skills/
   
   # 全局级别
   cp -r kb-manager ~/.kiro/skills/
   cp -r kb-reader ~/.kiro/skills/
   ```

2. **通过 Kiro 界面导入**:
   - 打开 "Agent Steering & Skills" 面板
   - 点击 `+` 按钮选择 "Import a skill"
   - 选择 "Local folder" 并选择对应的技能目录

3. **在 Kiro 中使用**:
   ```
   # 上传文档
   /kb-manager upload document.pdf
   
   # 查询知识库
   /kb-reader query 公司政策是什么？
   
   # 查看统计信息
   /kb-manager stats
   /kb-reader stats
   ```

#### Claude Code

1. **复制到 Claude Skills 目录**:
   ```bash
   cp -r kb-manager ~/.claude/skills/
   cp -r kb-reader ~/.claude/skills/
   ```

2. **使用技能**:
   ```
   @kb-manager upload document.pdf
   @kb-reader query 相关问题
   ```

#### 其他 AI Agent 平台

系统遵循 [Agent Skills 标准](https://agentskills.io/)，可以轻松集成到支持该标准的任何平台：

- **OpenClaw**: 复制到 `.openclaw/skills/` 目录
- **OpenCode**: 复制到 `.opencode/skills/` 目录
- **Cursor**: 作为插件或工具集成
- **自定义 Agent**: 通过 API 或命令行接口集成

## 🌐 应用场景

### 企业知识管理
- **内部文档库**: 管理公司政策、流程、技术文档
- **客服知识库**: 为客服系统提供智能问答支持
- **培训材料**: 构建员工培训和学习资源库

### AI Agent 增强
- **开发助手**: 为 IDE 和代码编辑器提供项目相关知识查询
- **智能客服**: 增强聊天机器人的领域知识
- **OpenClaw Agent**: 为 OpenClaw 平台提供企业知识库支持
- **自定义 Agent**: 为特定业务场景的 AI 助手提供知识支持

### 研发团队
- **技术文档**: 管理 API 文档、架构设计、最佳实践
- **代码知识库**: 存储和查询代码片段、解决方案
- **项目文档**: 需求文档、设计文档的集中管理

### 教育培训
- **课程材料**: 管理教学资源和参考资料
- **学习助手**: 为学生提供智能答疑服务
- **知识评估**: 基于知识库内容的学习效果评估

## 🏗️ 系统架构

### 数据存储

系统使用固定的系统级目录存储数据，确保多应用间的数据共享：

- **Windows**: `C:/ProgramData/kb-data/`
- **Linux/Mac**: `/usr/local/share/kb-data/` 或 `~/.local/share/kb-data/`

```
kb-data/
├── chroma_db/     # 向量数据库
└── documents/     # 原始文档
```

### 权限模型

- **kb-manager**: 完整权限，可创建、修改、删除数据
- **kb-reader**: 严格只读，仅能查询和浏览数据

### 分布式部署

```
应用 A (管理端)          应用 B (用户端)           应用 C (用户端)
├── kb-manager           ├── kb-reader            ├── kb-reader  
│   ├── 上传文档          │   ├── 查询知识库        │   ├── 查询知识库
│   ├── 管理知识库        │   └── 浏览文档          │   └── 浏览文档
│   └── 系统维护          └── 只读访问              └── 只读访问
└── 系统级数据目录 ←──────────────┴─────────────────────┘
```

## ⚙️ 配置选项

### kb-manager 配置

```json
{
  "embeddingProvider": "dashscope",
  "embeddingModel": "text-embedding-v3",
  "embeddingBaseUrl": "https://dashscope.aliyuncs.com/compatible-mode/v1",
  "chunkSize": 500,
  "chunkOverlap": 50,
  "retrievalTopK": 5,
  "collectionName": "enterprise_kb",
  "vectorDimension": 1024
}
```

### kb-reader 配置

```json
{
  "embeddingProvider": "dashscope",
  "embeddingModel": "text-embedding-v3",
  "retrievalTopK": 5,
  "vectorThreshold": 0.3,
  "collectionName": "enterprise_kb",
  "maxResults": 10
}
```

## 🔧 开发指南

### 添加新功能

1. Fork 本仓库
2. 创建功能分支: `git checkout -b feature/new-feature`
3. 提交更改: `git commit -am 'Add new feature'`
4. 推送分支: `git push origin feature/new-feature`
5. 创建 Pull Request

### 代码规范

- 遵循 PEP 8 Python 代码规范
- 添加适当的文档字符串
- 编写单元测试
- 确保向后兼容性

## 📊 性能指标

- **处理速度**: ~100页/分钟 (PDF)
- **搜索延迟**: <500ms (本地向量搜索)
- **存储效率**: ~1MB/1000页文档
- **支持规模**: 10万+文档块

## 🔒 安全特性

- **本地存储**: 所有数据保存在本地，不上传云端
- **API 安全**: 支持多种 API 提供商，密钥环境变量管理
- **权限分离**: 管理和查询权限严格分离
- **数据隔离**: 每个组件实例独立的数据存储

## 🤝 贡献

欢迎贡献代码！请查看 [贡献指南](CONTRIBUTING.md) 了解详细信息。

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🙏 致谢

- [ChromaDB](https://github.com/chroma-core/chroma) - 向量数据库
- [OpenAI](https://openai.com/) - API 接口标准
- [DashScope](https://dashscope.aliyuncs.com/) - 嵌入模型服务
- [Agent Skills](https://agentskills.io/) - AI Agent 技能标准

## 📞 支持

如果你遇到问题或有建议，请：

1. 查看 [FAQ](docs/FAQ.md)
2. 搜索 [Issues](https://github.com/your-username/enterprise-kb-system/issues)
3. 创建新的 Issue
4. 联系维护者

---

**让 AI 系统拥有企业级知识库能力！** 🚀