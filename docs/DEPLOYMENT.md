# 部署指南

本文档详细介绍了 Kiro Knowledge Base Skills 的各种部署场景和最佳实践。

## 🏗️ 部署架构

### 单机部署

```
┌─────────────────────────────────────┐
│           单台机器                    │
├─────────────────────────────────────┤
│  Agent A (管理员)                    │
│  ├── kb-manager                     │
│  └── 完整权限                        │
├─────────────────────────────────────┤
│  Agent B (用户1)                     │
│  ├── kb-reader                      │
│  └── 只读权限                        │
├─────────────────────────────────────┤
│  Agent C (用户2)                     │
│  ├── kb-reader                      │
│  └── 只读权限                        │
├─────────────────────────────────────┤
│  系统数据目录                         │
│  └── C:/ProgramData/kb-data/        │
└─────────────────────────────────────┘
```

### 分布式部署

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│    机器 A        │    │    机器 B        │    │    机器 C        │
│  (管理节点)       │    │   (用户节点)      │    │   (用户节点)      │
├─────────────────┤    ├─────────────────┤    ├─────────────────┤
│ Agent-Admin     │    │ Agent-User1     │    │ Agent-User2     │
│ ├── kb-manager  │    │ ├── kb-reader   │    │ ├── kb-reader   │
│ └── 管理权限     │    │ └── 只读权限     │    │ └── 只读权限     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │   共享存储        │
                    │ (NFS/SMB/云存储) │
                    │  kb-data/       │
                    └─────────────────┘
```

## 🚀 部署步骤

### 1. 环境准备

#### 系统要求

- **操作系统**: Windows 10+, macOS 10.15+, Ubuntu 18.04+
- **Python**: 3.8 或更高版本
- **内存**: 最小 4GB，推荐 8GB+
- **存储**: 至少 1GB 可用空间
- **网络**: 访问 DashScope/OpenAI API

#### 依赖安装

```bash
# 更新系统包管理器
sudo apt update  # Ubuntu
brew update      # macOS

# 安装 Python 3.8+
sudo apt install python3 python3-pip  # Ubuntu
brew install python3                   # macOS

# 验证安装
python3 --version
pip3 --version
```

### 2. 管理节点部署

#### 2.1 安装 kb-manager

```bash
# 克隆项目
git clone https://github.com/your-username/kiro-kb-skills.git
cd kiro-kb-skills/skills

# 安装 kb-manager
cd kb-manager
pip3 install -r requirements.txt
```

#### 2.2 配置环境

```bash
# 设置 API 密钥
export DASHSCOPE_API_KEY='your-dashscope-api-key'

# 或者创建 .env 文件
echo "DASHSCOPE_API_KEY=your-dashscope-api-key" > .env
```

#### 2.3 初始化系统

```bash
# 初始化知识库系统
python3 main.py setup

# 验证安装
python3 main.py stats
```

#### 2.4 上传初始文档

```bash
# 上传文档
python3 main.py upload /path/to/document.pdf "文档名称"

# 批量上传
for file in /path/to/documents/*.pdf; do
    python3 main.py upload "$file" "$(basename "$file")"
done
```

### 3. 用户节点部署

#### 3.1 安装 kb-reader

```bash
# 在用户节点上
git clone https://github.com/your-username/kiro-kb-skills.git
cd kiro-kb-skills/skills/kb-reader

# 安装依赖
pip3 install -r requirements.txt
```

#### 3.2 配置访问

```bash
# 设置相同的 API 密钥
export DASHSCOPE_API_KEY='your-dashscope-api-key'

# 测试连接
python3 main.py stats
```

## 🌐 分布式部署配置

### 网络文件系统 (NFS)

#### 服务端配置 (管理节点)

```bash
# 安装 NFS 服务器
sudo apt install nfs-kernel-server

# 创建共享目录
sudo mkdir -p /srv/kb-data
sudo chown nobody:nogroup /srv/kb-data
sudo chmod 755 /srv/kb-data

# 配置 NFS 导出
echo "/srv/kb-data *(rw,sync,no_subtree_check,no_root_squash)" | sudo tee -a /etc/exports

# 重启 NFS 服务
sudo systemctl restart nfs-kernel-server
sudo exportfs -a
```

#### 客户端配置 (用户节点)

```bash
# 安装 NFS 客户端
sudo apt install nfs-common

# 创建挂载点
sudo mkdir -p /usr/local/share/kb-data

# 挂载 NFS 共享
sudo mount -t nfs server-ip:/srv/kb-data /usr/local/share/kb-data

# 设置开机自动挂载
echo "server-ip:/srv/kb-data /usr/local/share/kb-data nfs defaults 0 0" | sudo tee -a /etc/fstab
```

### SMB/CIFS 共享 (Windows)

#### 服务端配置

```powershell
# 创建共享目录
New-Item -ItemType Directory -Path "C:\kb-data-share" -Force

# 设置共享
New-SmbShare -Name "kb-data" -Path "C:\kb-data-share" -FullAccess "Everyone"

# 设置权限
Grant-SmbShareAccess -Name "kb-data" -AccountName "Everyone" -AccessRight Full -Force
```

#### 客户端配置

```bash
# Linux 客户端
sudo apt install cifs-utils

# 创建挂载点
sudo mkdir -p /usr/local/share/kb-data

# 挂载 SMB 共享
sudo mount -t cifs //server-ip/kb-data /usr/local/share/kb-data -o username=user,password=pass

# Windows 客户端
net use Z: \\server-ip\kb-data
```

## 🐳 容器化部署

### Docker Compose 配置

```yaml
# docker-compose.yml
version: '3.8'

services:
  kb-manager:
    build:
      context: ./kb-manager
      dockerfile: Dockerfile
    environment:
      - DASHSCOPE_API_KEY=${DASHSCOPE_API_KEY}
    volumes:
      - kb-data:/usr/local/share/kb-data
      - ./documents:/app/documents
    ports:
      - "8000:8000"
    networks:
      - kb-network

  kb-reader-1:
    build:
      context: ./kb-reader
      dockerfile: Dockerfile
    environment:
      - DASHSCOPE_API_KEY=${DASHSCOPE_API_KEY}
    volumes:
      - kb-data:/usr/local/share/kb-data:ro
    ports:
      - "8001:8000"
    networks:
      - kb-network
    depends_on:
      - kb-manager

  kb-reader-2:
    build:
      context: ./kb-reader
      dockerfile: Dockerfile
    environment:
      - DASHSCOPE_API_KEY=${DASHSCOPE_API_KEY}
    volumes:
      - kb-data:/usr/local/share/kb-data:ro
    ports:
      - "8002:8000"
    networks:
      - kb-network
    depends_on:
      - kb-manager

volumes:
  kb-data:
    driver: local

networks:
  kb-network:
    driver: bridge
```

### Dockerfile 示例

```dockerfile
# kb-manager/Dockerfile
FROM python:3.9-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件
COPY requirements.txt .

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用代码
COPY . .

# 创建数据目录
RUN mkdir -p /usr/local/share/kb-data

# 暴露端口
EXPOSE 8000

# 启动命令
CMD ["python", "main.py", "serve"]
```

## ☁️ 云平台部署

### AWS 部署

#### EC2 实例配置

```bash
# 启动 EC2 实例
aws ec2 run-instances \
    --image-id ami-0abcdef1234567890 \
    --count 1 \
    --instance-type t3.medium \
    --key-name my-key-pair \
    --security-groups kb-security-group \
    --user-data file://user-data.sh
```

#### EFS 文件系统

```bash
# 创建 EFS 文件系统
aws efs create-file-system \
    --creation-token kb-data-$(date +%s) \
    --performance-mode generalPurpose \
    --throughput-mode provisioned \
    --provisioned-throughput-in-mibps 100

# 挂载 EFS
sudo mount -t efs fs-12345678:/ /usr/local/share/kb-data
```

### Azure 部署

#### 虚拟机配置

```bash
# 创建资源组
az group create --name kb-rg --location eastus

# 创建虚拟机
az vm create \
    --resource-group kb-rg \
    --name kb-manager-vm \
    --image UbuntuLTS \
    --admin-username azureuser \
    --generate-ssh-keys \
    --size Standard_B2s
```

#### Azure Files 共享

```bash
# 创建存储账户
az storage account create \
    --name kbstorageaccount \
    --resource-group kb-rg \
    --location eastus \
    --sku Standard_LRS

# 创建文件共享
az storage share create \
    --name kb-data \
    --account-name kbstorageaccount
```

## 🔧 配置管理

### 环境变量配置

```bash
# 生产环境配置
export ENVIRONMENT=production
export DASHSCOPE_API_KEY='prod-api-key'
export LOG_LEVEL=INFO
export MAX_CHUNK_SIZE=1000
export RETRIEVAL_TOP_K=10

# 开发环境配置
export ENVIRONMENT=development
export DASHSCOPE_API_KEY='dev-api-key'
export LOG_LEVEL=DEBUG
export MAX_CHUNK_SIZE=500
export RETRIEVAL_TOP_K=5
```

### 配置文件模板

```json
// config.production.json
{
  "embeddingProvider": "dashscope",
  "embeddingModel": "text-embedding-v3",
  "chunkSize": 1000,
  "chunkOverlap": 100,
  "retrievalTopK": 10,
  "vectorThreshold": 0.2,
  "enableRerank": true,
  "logLevel": "INFO"
}
```

## 📊 监控和日志

### 系统监控

```bash
# 安装监控工具
pip install psutil prometheus-client

# 启动监控
python monitoring/metrics_server.py
```

### 日志配置

```python
# logging_config.py
import logging
import logging.handlers

def setup_logging():
    logger = logging.getLogger('kb-skills')
    logger.setLevel(logging.INFO)
    
    # 文件处理器
    file_handler = logging.handlers.RotatingFileHandler(
        'logs/kb-skills.log',
        maxBytes=10*1024*1024,  # 10MB
        backupCount=5
    )
    
    # 控制台处理器
    console_handler = logging.StreamHandler()
    
    # 格式化器
    formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )
    
    file_handler.setFormatter(formatter)
    console_handler.setFormatter(formatter)
    
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)
    
    return logger
```

## 🔒 安全配置

### 防火墙设置

```bash
# Ubuntu UFW
sudo ufw allow ssh
sudo ufw allow 8000/tcp
sudo ufw enable

# CentOS firewalld
sudo firewall-cmd --permanent --add-port=8000/tcp
sudo firewall-cmd --reload
```

### SSL/TLS 配置

```nginx
# nginx.conf
server {
    listen 443 ssl;
    server_name kb.yourdomain.com;
    
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    
    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## 🚨 故障排除

### 常见问题

1. **权限问题**
   ```bash
   sudo chown -R $(whoami):$(whoami) /usr/local/share/kb-data
   sudo chmod -R 755 /usr/local/share/kb-data
   ```

2. **网络连接问题**
   ```bash
   # 测试 API 连接
   curl -H "Authorization: Bearer $DASHSCOPE_API_KEY" \
        https://dashscope.aliyuncs.com/compatible-mode/v1/models
   ```

3. **存储空间不足**
   ```bash
   # 清理旧数据
   find /usr/local/share/kb-data -name "*.tmp" -delete
   
   # 压缩日志
   gzip /var/log/kb-skills/*.log
   ```

### 健康检查脚本

```bash
#!/bin/bash
# health_check.sh

echo "=== KB Skills 健康检查 ==="

# 检查服务状态
if pgrep -f "kb-manager" > /dev/null; then
    echo "✅ kb-manager 运行中"
else
    echo "❌ kb-manager 未运行"
fi

# 检查数据目录
if [ -d "/usr/local/share/kb-data" ]; then
    echo "✅ 数据目录存在"
    echo "   大小: $(du -sh /usr/local/share/kb-data | cut -f1)"
else
    echo "❌ 数据目录不存在"
fi

# 检查 API 连接
if curl -s -f "https://dashscope.aliyuncs.com" > /dev/null; then
    echo "✅ API 连接正常"
else
    echo "❌ API 连接失败"
fi

echo "=== 检查完成 ==="
```

## 📈 性能优化

### 系统调优

```bash
# 增加文件描述符限制
echo "* soft nofile 65536" >> /etc/security/limits.conf
echo "* hard nofile 65536" >> /etc/security/limits.conf

# 优化内存设置
echo "vm.swappiness=10" >> /etc/sysctl.conf
echo "vm.dirty_ratio=15" >> /etc/sysctl.conf
```

### 数据库优化

```python
# chromadb_config.py
CHROMA_CONFIG = {
    "anonymized_telemetry": False,
    "allow_reset": False,
    "is_persistent": True,
    "persist_directory": "/usr/local/share/kb-data/chroma_db"
}
```

---

这个部署指南涵盖了从单机到分布式、从本地到云平台的各种部署场景。根据你的具体需求选择合适的部署方式。