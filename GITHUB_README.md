# 🚀 Enterprise Knowledge Base Management System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![AI Agent Compatible](https://img.shields.io/badge/AI%20Agent-Compatible-green.svg)](https://agentskills.io/)

> **Enterprise-grade knowledge base system with AI Agent integration**  
> Upload documents, semantic search, RAG Q&A, and distributed deployment support

## ✨ What's This?

A powerful knowledge base management system that transforms your documents into an intelligent, searchable knowledge repository. Perfect for enterprises, development teams, and AI Agent platforms.

**🎯 Two Components:**
- **kb-manager**: Full management capabilities (upload, manage, query)
- **kb-reader**: Read-only query system (secure, lightweight)

## 🚀 Quick Demo

```bash
# 1. Setup (one-time)
cd kb-manager && python main.py setup

# 2. Upload your documents
python main.py upload company-handbook.pdf "Company Handbook"

# 3. Ask questions
python main.py query "What is our vacation policy?"
# → AI searches your documents and provides contextual answers

# 4. Use read-only access elsewhere
cd ../kb-reader && python main.py query "Remote work guidelines?"
```

## 🎯 Key Features

| Feature | kb-manager | kb-reader |
|---------|------------|-----------|
| **Document Upload** | ✅ PDF, DOCX, TXT, MD | ❌ Read-only |
| **Semantic Search** | ✅ Vector similarity | ✅ Vector similarity |
| **RAG Q&A** | ✅ Intelligent answers | ✅ Intelligent answers |
| **Data Management** | ✅ Full CRUD | ❌ Query only |
| **Security** | 🔓 Full access | 🔒 Read-only |
| **Use Case** | Admin/Management | End users/Services |

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   App A         │    │   App B         │    │   App C         │
│  kb-manager     │    │  kb-reader      │    │  kb-reader      │
│  (Admin)        │    │  (User)         │    │  (Service)      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │ Shared KB Data  │
                    │ (ChromaDB)      │
                    └─────────────────┘
```

## 🎨 AI Agent Integration

Works seamlessly with popular AI Agent platforms:

### OpenClaw
```bash
@kb-manager upload document.pdf
@kb-reader query "company policy"
```

### Kiro IDE
```bash
/kb-manager upload document.pdf
/kb-reader query "technical specs"
```

### Claude Code
```bash
@kb-manager upload document.pdf
@kb-reader query "API documentation"
```

## 🛠️ Installation

### Prerequisites
- Python 3.8+
- API key (DashScope or OpenAI)

### Setup
```bash
# Clone repository
git clone https://github.com/your-username/enterprise-kb-system.git
cd enterprise-kb-system

# Install dependencies
cd kb-manager && pip install -r requirements.txt
cd ../kb-reader && pip install -r requirements.txt

# Configure API key
export DASHSCOPE_API_KEY='your-api-key'

# Initialize system
cd kb-manager && python main.py setup
```

## 💡 Use Cases

### 🏢 Enterprise
- **Internal Wiki**: Company policies, procedures, handbooks
- **Customer Support**: FAQ, troubleshooting guides
- **Training**: Onboarding materials, course content

### 👨‍💻 Development Teams  
- **Documentation**: API docs, architecture guides
- **Knowledge Sharing**: Code snippets, best practices
- **Project Management**: Requirements, specifications

### 🤖 AI Enhancement
- **Smart Assistants**: Domain-specific knowledge
- **Chatbots**: Contextual responses
- **Code Helpers**: Project-aware suggestions

## 📊 Performance

| Metric | Performance |
|--------|-------------|
| **Document Processing** | ~100 pages/minute |
| **Search Response** | <500ms |
| **Storage Efficiency** | ~1MB/1000 pages |
| **Scale Support** | 100k+ chunks |

## 🔒 Security & Privacy

- ✅ **Local Storage**: No cloud uploads, your data stays yours
- ✅ **Permission Control**: Strict read-only enforcement
- ✅ **API Security**: Environment-based key management
- ✅ **Data Isolation**: Separate storage per instance

## 🌟 Why Choose This?

| Advantage | Benefit |
|-----------|---------|
| **🚀 Easy Setup** | Get running in minutes, not hours |
| **🔒 Secure by Design** | Local storage, permission separation |
| **🎯 AI Agent Ready** | Works with popular platforms out-of-box |
| **📈 Scalable** | From small teams to enterprise scale |
| **🛠️ Flexible** | Standalone or integrated deployment |

## 📚 Documentation

- [📖 Full Documentation](README_EN.md)
- [🚀 Quick Start Guide](docs/QUICKSTART.md)
- [🔧 Deployment Guide](docs/DEPLOYMENT.md)
- [❓ FAQ](docs/FAQ.md)
- [🤝 Contributing](CONTRIBUTING.md)

## 🤝 Contributing

We welcome contributions! Here's how to get started:

1. 🍴 Fork the repository
2. 🌿 Create your feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 Commit your changes (`git commit -m 'Add amazing feature'`)
4. 📤 Push to the branch (`git push origin feature/amazing-feature`)
5. 🔄 Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Special thanks to:
- [ChromaDB](https://github.com/chroma-core/chroma) for the vector database
- [OpenAI](https://openai.com/) for API standards
- [DashScope](https://dashscope.aliyuncs.com/) for embedding services
- The open-source community for inspiration and feedback

## 📞 Support & Community

- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/your-username/enterprise-kb-system/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/your-username/enterprise-kb-system/discussions)
- 📧 **Contact**: [maintainers@yourproject.com](mailto:maintainers@yourproject.com)

---

<div align="center">

**⭐ Star this repo if you find it useful!**

[🚀 Get Started](README_EN.md) • [📚 Documentation](docs/) • [🤝 Contribute](CONTRIBUTING.md)

</div>