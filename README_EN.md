# Enterprise Knowledge Base Management System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![AI Agent Compatible](https://img.shields.io/badge/AI%20Agent-Compatible-green.svg)](https://agentskills.io/)
[![OpenClaw Skills](https://img.shields.io/badge/OpenClaw-Skills-blue.svg)](https://openclaw.ai/)

An enterprise-grade knowledge base management system supporting document upload, semantic search, RAG Q&A, and distributed deployment. Can be used as a standalone system or integrated with various AI Agent platforms (Kiro IDE, Claude Code, OpenClaw, etc.).

[中文文档](README.md) | [English Documentation](README_EN.md)

## 🚀 Features

### 📚 kb-manager (Knowledge Base Manager)
- ✅ **Document Upload & Management** - Support for PDF, DOCX, TXT, Markdown formats
- ✅ **Intelligent Document Chunking** - Configurable chunking strategies
- ✅ **Semantic Search** - High-precision search based on vector similarity
- ✅ **RAG Q&A** - Intelligent Q&A combining retrieval and generation
- ✅ **System-level Data Management** - Cross-application data sharing
- ✅ **Multiple Embedding Models** - Support for DashScope, OpenAI, etc.

### 🔍 kb-reader (Knowledge Base Reader)
- ✅ **Read-only Query** - Secure read-only access mode
- ✅ **Lightweight Design** - Minimal resource usage focused on query functionality
- ✅ **Multiple Search Modes** - Semantic search, keyword search, hybrid search
- ✅ **Permission Isolation** - Strict read-only permissions, cannot modify data
- ✅ **Distributed Deployment** - Can be deployed across different applications or services

## 📁 Project Structure

```
enterprise-kb-system/
├── kb-manager/           # Knowledge Base Manager (Full Permissions)
│   ├── src/             # Core source code
│   ├── main.py          # Main entry point
│   ├── config.json      # Configuration file
│   ├── requirements.txt # Dependencies
│   └── SKILL.md         # Skill definition document
├── kb-reader/           # Knowledge Base Reader (Read-only Permissions)
│   ├── src/             # Core source code
│   ├── main.py          # Main entry point
│   ├── config.json      # Configuration file
│   ├── requirements.txt # Dependencies
│   └── SKILL.md         # Skill definition document
└── README.md            # Project documentation
```

## 🛠️ Tech Stack

- **Vector Database**: ChromaDB (local storage, no Docker required)
- **Embedding Models**: DashScope text-embedding-v3 (1024-dim) / OpenAI
- **Document Processing**: PyPDF2, python-docx, markdown
- **Search Algorithm**: Cosine similarity + keyword matching
- **API Framework**: OpenAI-compatible interface

## 🚀 Quick Start

### 1. Requirements

- Python 3.8+
- DashScope API key or OpenAI API key

### 2. Install Dependencies

```bash
# Install kb-manager dependencies
cd kb-manager
pip install -r requirements.txt

# Install kb-reader dependencies  
cd ../kb-reader
pip install -r requirements.txt
```

### 3. Configure API Key

```bash
# DashScope (Recommended)
export DASHSCOPE_API_KEY='your-dashscope-api-key'

# Or OpenAI
export OPENAI_API_KEY='your-openai-api-key'
```

### 4. Initialize System

```bash
# Use kb-manager to initialize system environment
cd kb-manager
python main.py setup
```

### 5. Upload Documents

```bash
# Upload documents to knowledge base
python main.py upload /path/to/document.pdf "Document Name"
```

### 6. Query Test

```bash
# Use kb-reader to query
cd ../kb-reader
python main.py query "your question"
```

## 📋 Usage

### As Standalone System

```bash
# Direct command line usage
cd kb-manager
python main.py upload document.pdf "Document Name"
python main.py query "your question"

cd ../kb-reader  
python main.py query "your question"
python main.py stats
```

### Integration with AI Agent Platforms

#### Kiro IDE

1. **Copy to Kiro Skills Directory**:
   ```bash
   # Project level
   cp -r kb-manager /path/to/your/project/.kiro/skills/
   cp -r kb-reader /path/to/your/project/.kiro/skills/
   
   # Global level
   cp -r kb-manager ~/.kiro/skills/
   cp -r kb-reader ~/.kiro/skills/
   ```

2. **Import via Kiro Interface**:
   - Open "Agent Steering & Skills" panel
   - Click `+` button and select "Import a skill"
   - Choose "Local folder" and select the corresponding skill directory

3. **Usage in Kiro**:
   ```
   # Upload documents
   /kb-manager upload document.pdf
   
   # Query knowledge base
   /kb-reader query What is the company policy?
   
   # View statistics
   /kb-manager stats
   /kb-reader stats
   ```

#### Claude Code

1. **Copy to Claude Skills Directory**:
   ```bash
   cp -r kb-manager ~/.claude/skills/
   cp -r kb-reader ~/.claude/skills/
   ```

2. **Use Skills**:
   ```
   @kb-manager upload document.pdf
   @kb-reader query related questions
   ```

#### OpenClaw

1. **Copy to OpenClaw Skills Directory**:
   ```bash
   cp -r kb-manager ~/.openclaw/skills/
   cp -r kb-reader ~/.openclaw/skills/
   ```

2. **Use in OpenClaw**:
   ```
   @kb-manager upload document.pdf
   @kb-reader query company policy
   ```

#### Other AI Agent Platforms

The system follows the [Agent Skills Standard](https://agentskills.io/) and can be easily integrated into any platform supporting this standard:

- **OpenCode**: Copy to `.opencode/skills/` directory
- **Cursor**: Integrate as plugin or tool
- **Custom Agent**: Integrate via API or command line interface

## 🌐 Use Cases

### Enterprise Knowledge Management
- **Internal Document Library**: Manage company policies, processes, technical documentation
- **Customer Service Knowledge Base**: Provide intelligent Q&A support for customer service systems
- **Training Materials**: Build employee training and learning resource libraries

### AI Agent Enhancement
- **Development Assistant**: Provide project-related knowledge queries for IDEs and code editors
- **Intelligent Customer Service**: Enhance chatbot domain knowledge
- **OpenClaw Agent**: Provide enterprise knowledge base support for OpenClaw platform
- **Custom Agent**: Provide knowledge support for AI assistants in specific business scenarios

### Development Teams
- **Technical Documentation**: Manage API docs, architecture designs, best practices
- **Code Knowledge Base**: Store and query code snippets, solutions
- **Project Documentation**: Centralized management of requirements and design documents

### Education & Training
- **Course Materials**: Manage teaching resources and reference materials
- **Learning Assistant**: Provide intelligent Q&A services for students
- **Knowledge Assessment**: Learning effectiveness evaluation based on knowledge base content

## 🏗️ System Architecture

### Data Storage

The system uses fixed system-level directories for data storage, ensuring data sharing across applications:

- **Windows**: `C:/ProgramData/kb-data/`
- **Linux/Mac**: `/usr/local/share/kb-data/` or `~/.local/share/kb-data/`

```
kb-data/
├── chroma_db/     # Vector database
└── documents/     # Original documents
```

### Permission Model

- **kb-manager**: Full permissions, can create, modify, delete data
- **kb-reader**: Strict read-only, can only query and browse data

### Distributed Deployment

```
App A (Management)       App B (User)             App C (User)
├── kb-manager           ├── kb-reader            ├── kb-reader  
│   ├── Upload docs      │   ├── Query KB         │   ├── Query KB
│   ├── Manage KB        │   └── Browse docs      │   └── Browse docs
│   └── System maint.    └── Read-only access     └── Read-only access
└── System Data Directory ←──────────┴─────────────────────┘
```

## ⚙️ Configuration Options

### kb-manager Configuration

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

### kb-reader Configuration

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

## 🔧 Development Guide

### Adding New Features

1. Fork this repository
2. Create feature branch: `git checkout -b feature/new-feature`
3. Commit changes: `git commit -am 'Add new feature'`
4. Push branch: `git push origin feature/new-feature`
5. Create Pull Request

### Code Standards

- Follow PEP 8 Python code standards
- Add appropriate docstrings
- Write unit tests
- Ensure backward compatibility

## 📊 Performance Metrics

- **Processing Speed**: ~100 pages/minute (PDF)
- **Search Latency**: <500ms (local vector search)
- **Storage Efficiency**: ~1MB/1000 pages of documents
- **Supported Scale**: 100k+ document chunks

## 🔒 Security Features

- **Local Storage**: All data stored locally, no cloud uploads
- **API Security**: Support for multiple API providers, environment variable key management
- **Permission Separation**: Strict separation of management and query permissions
- **Data Isolation**: Independent data storage per component instance

## 🤝 Contributing

Contributions are welcome! Please see [Contributing Guide](CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [ChromaDB](https://github.com/chroma-core/chroma) - Vector database
- [OpenAI](https://openai.com/) - API interface standard
- [DashScope](https://dashscope.aliyuncs.com/) - Embedding model service
- [Agent Skills](https://agentskills.io/) - AI Agent skills standard
- [OpenClaw](https://openclaw.ai/) - AI Agent platform

## 📞 Support

If you encounter issues or have suggestions:

1. Check [FAQ](docs/FAQ.md)
2. Search [Issues](https://github.com/your-username/enterprise-kb-system/issues)
3. Create new Issue
4. Contact maintainers

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=your-username/enterprise-kb-system&type=Date)](https://star-history.com/#your-username/enterprise-kb-system&Date)

---

**Empower AI systems with enterprise-grade knowledge base capabilities!** 🚀

## 📈 Roadmap

- [ ] Enhanced reranking capabilities
- [ ] Additional document format support (PPTX, XLSX, HTML)
- [ ] Advanced search filters and faceting
- [ ] Integration with more embedding providers
- [ ] Web API interface for HTTP-based integration
- [ ] Docker containerization for easy deployment
- [ ] Multi-language support
- [ ] Real-time document synchronization
- [ ] Advanced analytics and reporting
- [ ] Enterprise SSO integration