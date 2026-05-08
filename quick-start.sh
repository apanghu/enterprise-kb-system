#!/bin/bash

# Kiro Knowledge Base Skills - 快速开始脚本
# 这个脚本将帮助你快速设置和测试 KB Skills

set -e  # 遇到错误时退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_header() {
    echo -e "${BLUE}"
    echo "=================================================="
    echo "  Kiro Knowledge Base Skills - 快速开始"
    echo "=================================================="
    echo -e "${NC}"
}

# 检查系统要求
check_requirements() {
    print_info "检查系统要求..."
    
    # 检查 Python 版本
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
        print_success "Python 版本: $PYTHON_VERSION"
        
        # 检查版本是否 >= 3.8
        if python3 -c 'import sys; exit(0 if sys.version_info >= (3, 8) else 1)'; then
            print_success "Python 版本符合要求 (>= 3.8)"
        else
            print_error "Python 版本过低，需要 3.8 或更高版本"
            exit 1
        fi
    else
        print_error "未找到 Python3，请先安装 Python 3.8+"
        exit 1
    fi
    
    # 检查 pip
    if command -v pip3 &> /dev/null; then
        print_success "pip3 已安装"
    else
        print_error "未找到 pip3，请先安装 pip"
        exit 1
    fi
    
    # 检查 git
    if command -v git &> /dev/null; then
        print_success "Git 已安装"
    else
        print_warning "未找到 Git，某些功能可能不可用"
    fi
}

# 检查 API 密钥
check_api_key() {
    print_info "检查 API 密钥配置..."
    
    if [ -n "$DASHSCOPE_API_KEY" ]; then
        print_success "DashScope API 密钥已设置"
        return 0
    elif [ -n "$OPENAI_API_KEY" ]; then
        print_success "OpenAI API 密钥已设置"
        return 0
    else
        print_warning "未检测到 API 密钥"
        echo ""
        echo "请设置以下环境变量之一："
        echo "  export DASHSCOPE_API_KEY='your-dashscope-key'"
        echo "  export OPENAI_API_KEY='your-openai-key'"
        echo ""
        read -p "是否继续安装？(y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "安装已取消"
            exit 0
        fi
    fi
}

# 安装依赖
install_dependencies() {
    print_info "安装 kb-manager 依赖..."
    cd kb-manager
    
    if [ -f "requirements.txt" ]; then
        pip3 install -r requirements.txt
        print_success "kb-manager 依赖安装完成"
    else
        print_error "未找到 kb-manager/requirements.txt"
        exit 1
    fi
    
    cd ..
    
    print_info "安装 kb-reader 依赖..."
    cd kb-reader
    
    if [ -f "requirements.txt" ]; then
        pip3 install -r requirements.txt
        print_success "kb-reader 依赖安装完成"
    else
        print_error "未找到 kb-reader/requirements.txt"
        exit 1
    fi
    
    cd ..
}

# 初始化系统
initialize_system() {
    print_info "初始化知识库系统..."
    
    cd kb-manager
    
    if python3 main.py setup; then
        print_success "系统初始化完成"
    else
        print_warning "系统初始化可能失败，请检查错误信息"
    fi
    
    cd ..
}

# 运行测试
run_tests() {
    print_info "运行基本测试..."
    
    # 测试 kb-manager
    print_info "测试 kb-manager..."
    cd kb-manager
    
    if python3 main.py stats; then
        print_success "kb-manager 测试通过"
    else
        print_warning "kb-manager 测试失败"
    fi
    
    cd ..
    
    # 测试 kb-reader
    print_info "测试 kb-reader..."
    cd kb-reader
    
    if python3 main.py stats; then
        print_success "kb-reader 测试通过"
    else
        print_warning "kb-reader 测试失败"
    fi
    
    cd ..
}

# 创建示例文档
create_sample_document() {
    print_info "创建示例文档..."
    
    cat > sample_document.txt << 'EOF'
# Kiro Knowledge Base Skills 示例文档

这是一个示例文档，用于测试知识库功能。

## 功能特性

1. **文档上传**: 支持 PDF、DOCX、TXT、Markdown 格式
2. **语义搜索**: 基于向量相似度的智能搜索
3. **RAG 问答**: 结合检索和生成的问答系统
4. **多 Agent 支持**: 支持分布式部署

## 使用方法

### 上传文档
```bash
python main.py upload document.pdf "文档名称"
```

### 查询知识库
```bash
python main.py query "你的问题"
```

### 查看统计信息
```bash
python main.py stats
```

## 技术架构

- **向量数据库**: ChromaDB
- **嵌入模型**: DashScope text-embedding-v3
- **文档处理**: PyPDF2, python-docx
- **搜索算法**: 余弦相似度

这个示例文档包含了系统的基本信息，可以用来测试搜索和问答功能。
EOF

    print_success "示例文档已创建: sample_document.txt"
}

# 上传示例文档
upload_sample_document() {
    if [ -f "sample_document.txt" ]; then
        print_info "上传示例文档到知识库..."
        
        cd kb-manager
        
        if python3 main.py upload ../sample_document.txt "Kiro KB Skills 示例文档"; then
            print_success "示例文档上传成功"
        else
            print_warning "示例文档上传失败，可能是 API 密钥问题"
        fi
        
        cd ..
    fi
}

# 演示查询功能
demo_query() {
    print_info "演示查询功能..."
    
    cd kb-reader
    
    echo ""
    echo "尝试查询: '如何上传文档'"
    if python3 main.py query "如何上传文档"; then
        print_success "查询演示完成"
    else
        print_warning "查询演示失败"
    fi
    
    cd ..
}

# 显示使用指南
show_usage_guide() {
    print_info "安装完成！使用指南："
    echo ""
    echo "📚 kb-manager (知识库管理器):"
    echo "  cd kb-manager"
    echo "  python3 main.py upload <文件路径> [文档名称]  # 上传文档"
    echo "  python3 main.py query <查询内容>            # 查询知识库"
    echo "  python3 main.py list                       # 列出文档"
    echo "  python3 main.py stats                      # 显示统计"
    echo ""
    echo "🔍 kb-reader (知识库查询器):"
    echo "  cd kb-reader"
    echo "  python3 main.py query <查询内容>            # 查询知识库"
    echo "  python3 main.py list                       # 列出文档"
    echo "  python3 main.py stats                      # 显示统计"
    echo ""
    echo "🎯 在 Kiro 中使用:"
    echo "  1. 复制技能到 .kiro/skills/ 目录"
    echo "  2. 或通过 Kiro 界面导入技能"
    echo "  3. 使用 /kb-manager 或 /kb-reader 调用"
    echo ""
    echo "📖 更多信息:"
    echo "  - README.md: 完整文档"
    echo "  - docs/FAQ.md: 常见问题"
    echo "  - docs/DEPLOYMENT.md: 部署指南"
    echo ""
    print_success "享受使用 Kiro Knowledge Base Skills！"
}

# 主函数
main() {
    print_header
    
    # 检查是否在正确的目录
    if [ ! -d "kb-manager" ] || [ ! -d "kb-reader" ]; then
        print_error "请在 skills 目录中运行此脚本"
        exit 1
    fi
    
    # 执行安装步骤
    check_requirements
    check_api_key
    install_dependencies
    initialize_system
    run_tests
    
    # 如果有 API 密钥，创建和上传示例文档
    if [ -n "$DASHSCOPE_API_KEY" ] || [ -n "$OPENAI_API_KEY" ]; then
        create_sample_document
        upload_sample_document
        demo_query
    else
        print_info "跳过示例文档创建（未设置 API 密钥）"
    fi
    
    show_usage_guide
}

# 错误处理
trap 'print_error "安装过程中发生错误，请检查上面的错误信息"; exit 1' ERR

# 运行主函数
main "$@"