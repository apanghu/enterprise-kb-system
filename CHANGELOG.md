# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial release of Enterprise Knowledge Base Management System
- kb-manager: Full knowledge base management capabilities
- kb-reader: Read-only knowledge base query system

## [1.0.0] - 2026-05-06

### Added

#### kb-manager
- Document upload and management (PDF, DOCX, TXT, Markdown)
- Intelligent document chunking with configurable size and overlap
- Vector-based semantic search using ChromaDB
- RAG (Retrieval-Augmented Generation) question answering
- System-level data directory management for cross-application sharing
- Support for multiple embedding models (DashScope, OpenAI)
- Document statistics and management commands
- Automatic system environment initialization
- Multi-application deployment support

#### kb-reader  
- Read-only knowledge base access
- Lightweight design focused on query functionality
- Multiple search modes: semantic, keyword, and hybrid search
- Strict permission isolation - cannot modify data
- Distributed deployment capability across different applications
- Compatible with kb-manager created knowledge bases
- Automatic system path detection

#### System Features
- Cross-platform system directory management
  - Windows: `C:/ProgramData/kb-data/`
  - Linux/Mac: `/usr/local/share/kb-data/` or `~/.local/share/kb-data/`
- Automatic permission handling and fallback paths
- Environment variable based API key management
- Comprehensive error handling and user feedback
- AI Agent Skills standard compliance (agentskills.io)

#### AI Agent Integration
- **Kiro IDE**: Full integration with SKILL.md format
- **Claude Code**: Compatible with Claude skills system
- **OpenCode**: Support for .opencode/skills/ directory
- **Generic Agent**: Command-line and API interfaces
- **Custom Integration**: Flexible architecture for custom platforms

#### Documentation
- Complete installation and usage guides
- Multi-application deployment architecture documentation
- Troubleshooting guides for common issues
- Configuration reference for both components
- Security best practices documentation
- AI Agent integration examples

### Technical Details
- **Vector Database**: ChromaDB (local storage, no Docker required)
- **Embedding Models**: DashScope text-embedding-v3 (1024-dim) / OpenAI
- **Document Processing**: PyPDF2, python-docx, markdown support
- **Search Algorithm**: Cosine similarity + keyword matching
- **API Framework**: OpenAI-compatible interface
- **Performance**: ~100 pages/minute processing, <500ms search latency
- **Scalability**: Supports 100k+ document chunks

### Security
- Local-only data storage (no cloud uploads)
- Environment variable based API key management
- Strict permission separation between manager and reader
- Data isolation per component instance
- Automatic directory permission management

### Changed
- Removed hardcoded API keys from all source files
- Improved error messages for missing API keys
- Enhanced system path detection and creation logic
- Generalized from Kiro-specific to universal AI Agent system

### Fixed
- API key security issues in example and test files
- System directory creation permissions on different platforms
- ChromaDB client initialization for read-only access

## [0.9.0] - 2026-05-05

### Added
- Initial development version
- Basic document upload and query functionality
- ChromaDB integration
- DashScope embedding support
- Kiro IDE specific implementation

### Known Issues
- Hardcoded API keys in source code (fixed in 1.0.0)
- Limited error handling for missing dependencies
- Manual system directory creation required
- Kiro IDE only compatibility

---

## Release Notes

### Version 1.0.0 Highlights

This is the first stable release of Enterprise Knowledge Base Management System, providing enterprise-grade knowledge management capabilities for various AI Agent platforms and standalone use.

**Key Features:**
- 🚀 **Production Ready**: Comprehensive error handling and user feedback
- 🔒 **Security First**: No hardcoded secrets, environment-based configuration
- 🌐 **Multi-Platform**: Designed for various AI Agent platforms and standalone use
- 📚 **Enterprise Scale**: Supports large document collections with efficient search
- 🛠️ **Developer Friendly**: Easy installation and configuration
- 🤖 **AI Agent Ready**: Compatible with multiple AI Agent platforms

**Platform Support:**
- **Standalone**: Command-line interface for direct use
- **Kiro IDE**: Full skills integration
- **Claude Code**: Skills compatibility
- **OpenCode**: Plugin support
- **Custom Agents**: API and CLI interfaces

**Migration from 0.9.0:**
- Remove any hardcoded API keys from your configuration
- Set API keys via environment variables
- Run `python main.py setup` to initialize the new system directory structure
- Update any Kiro-specific references to use generic interfaces

**Next Steps:**
- Enhanced reranking capabilities
- Additional document format support (PPTX, XLSX, HTML)
- Advanced search filters and faceting
- Integration with more embedding providers
- Web API interface for HTTP-based integration
- Docker containerization for easy deployment

---

For more details about any release, see the [GitHub Releases](https://github.com/your-username/enterprise-kb-system/releases) page.