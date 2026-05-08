# 常见问题解答 (FAQ)

## 🚀 安装和配置

### Q: 如何获取 DashScope API 密钥？

**A:** 
1. 访问 [阿里云 DashScope 控制台](https://dashscope.console.aliyun.com/)
2. 注册/登录阿里云账号
3. 开通 DashScope 服务
4. 在 API-KEY 管理页面创建新的 API 密钥
5. 设置环境变量：`export DASHSCOPE_API_KEY='your-api-key'`

### Q: 支持哪些文档格式？

**A:** 目前支持以下格式：
- **PDF**: `.pdf` 文件
- **Word**: `.docx` 文件  
- **文本**: `.txt` 文件
- **Markdown**: `.md` 文件

计划支持：`.pptx`, `.xlsx`, `.html`, `.epub`

### Q: 如何在 Windows 上设置环境变量？

**A:** 
```powershell
# 临时设置（当前会话）
$env:DASHSCOPE_API_KEY='your-api-key'

# 永久设置（系统级）
[Environment]::SetEnvironmentVariable("DASHSCOPE_API_KEY", "your-api-key", "User")
```

### Q: 可以使用 OpenAI 而不是 DashScope 吗？

**A:** 可以！修改配置文件：
```json
{
  "embeddingProvider": "openai",
  "embeddingModel": "text-embedding-3-small",
  "embeddingBaseUrl": "https://api.openai.com/v1"
}
```
然后设置：`export OPENAI_API_KEY='your-openai-key'`

## 🔧 使用问题

### Q: 上传文档后查询不到内容怎么办？

**A:** 检查以下几点：
1. **确认上传成功**：`python main.py stats` 查看文档数量
2. **检查分块**：确认文档被正确分块处理
3. **API 密钥**：确认 API 密钥正确且有效
4. **查询方式**：尝试不同的查询关键词
5. **重建索引**：删除 `chroma_db` 目录后重新上传

### Q: 搜索结果不准确怎么优化？

**A:** 可以调整以下参数：
```json
{
  "chunkSize": 500,        // 减小获得更精确的匹配
  "chunkOverlap": 50,      // 增加以保持上下文连续性
  "retrievalTopK": 10,     // 增加以获得更多候选结果
  "vectorThreshold": 0.3   // 降低以包含更多相关结果
}
```

### Q: 如何删除已上传的文档？

**A:** 
```bash
# 查看文档列表
python main.py list

# 删除特定文档（需要文档ID）
python main.py delete <document_id>

# 清空所有数据（谨慎使用）
rm -rf /path/to/kb-data/chroma_db
python main.py setup
```

### Q: 支持中文文档吗？

**A:** 完全支持！系统对中文文档有良好的支持：
- 中文 PDF 文档解析
- 中文文本分块和索引
- 中文语义搜索
- 中文问答生成

## 🌐 多 Agent 部署

### Q: 如何在多个 Agent 间共享知识库？

**A:** 系统自动使用固定的系统目录：
- **Windows**: `C:/ProgramData/kb-data/`
- **Linux/Mac**: `/usr/local/share/kb-data/`

所有 Agent 自动访问相同路径，无需额外配置。

### Q: kb-reader 提示"系统目录不存在"怎么办？

**A:** kb-reader 无法创建系统目录，需要先用 kb-manager 初始化：
```bash
# 在有 kb-manager 的 Agent 上运行
python main.py setup

# 然后在 kb-reader Agent 上测试
python main.py stats
```

### Q: 可以在不同机器上部署吗？

**A:** 可以，但需要共享存储：
1. **网络存储**: 使用 NFS、SMB 等共享 `kb-data` 目录
2. **数据库**: 配置 ChromaDB 使用网络数据库
3. **同步**: 定期同步数据目录

## 🔒 安全和权限

### Q: kb-reader 真的无法修改数据吗？

**A:** 是的，kb-reader 在代码层面强制只读：
- 无法创建目录或文件
- 无法上传或删除文档
- 无法修改配置或索引
- 任何写入操作都会抛出异常

### Q: API 密钥安全吗？

**A:** 系统采用安全的密钥管理：
- 仅通过环境变量读取
- 不在代码中硬编码
- 不写入日志文件
- 支持密钥轮换

### Q: 数据存储在哪里？

**A:** 所有数据存储在本地：
- 向量数据：`kb-data/chroma_db/`
- 原始文档：`kb-data/documents/`
- 不上传到任何云服务
- 完全本地化处理

## ⚡ 性能优化

### Q: 处理大文档很慢怎么办？

**A:** 优化建议：
1. **调整分块大小**：较大的 `chunkSize` 处理更快
2. **并行处理**：分批上传文档
3. **硬件升级**：增加内存和 CPU
4. **格式选择**：TXT 比 PDF 处理更快

### Q: 搜索响应慢怎么优化？

**A:** 
1. **减少 topK**：降低 `retrievalTopK` 值
2. **本地部署**：使用本地嵌入模型
3. **索引优化**：定期重建 ChromaDB 索引
4. **缓存结果**：对常见查询启用缓存

### Q: 内存占用过高怎么办？

**A:** 
1. **减小批处理大小**：处理文档时分批进行
2. **调整向量维度**：使用较小的嵌入模型
3. **清理缓存**：定期清理临时文件
4. **限制并发**：避免同时处理多个大文档

## 🛠️ 开发和集成

### Q: 如何在 Kiro 中调试技能？

**A:** 
1. **查看日志**：检查 Kiro 控制台输出
2. **独立测试**：在命令行中直接运行技能
3. **分步调试**：使用 `python -m pdb main.py`
4. **配置验证**：检查 `config.json` 格式

### Q: 如何自定义嵌入模型？

**A:** 修改 `src/embedder.py`：
```python
class CustomEmbedder(Embedder):
    def __init__(self):
        # 实现自定义嵌入逻辑
        pass
    
    def embed_text(self, text: str) -> List[float]:
        # 返回自定义嵌入向量
        pass
```

### Q: 如何添加新的文档格式支持？

**A:** 
1. 在 `src/parser.py` 中添加新的解析器
2. 在 `src/document_processor.py` 中注册格式
3. 更新 `requirements.txt` 添加依赖
4. 编写测试用例

## 🐛 故障排除

### Q: ChromaDB 初始化失败

**A:** 
```bash
# 检查权限
ls -la /path/to/kb-data/

# 重新创建目录
rm -rf /path/to/kb-data/chroma_db
python main.py setup

# 检查 Python 版本
python --version  # 需要 3.8+
```

### Q: 导入错误：ModuleNotFoundError

**A:** 
```bash
# 重新安装依赖
pip install -r requirements.txt --force-reinstall

# 检查 Python 路径
python -c "import sys; print(sys.path)"

# 虚拟环境问题
deactivate && source venv/bin/activate
```

### Q: API 调用失败

**A:** 
1. **检查网络**：`ping dashscope.aliyuncs.com`
2. **验证密钥**：在 DashScope 控制台测试
3. **检查配额**：确认 API 调用次数未超限
4. **代理设置**：如果使用代理，配置正确的代理设置

## 📞 获取更多帮助

如果以上答案没有解决你的问题：

1. **搜索 Issues**: [GitHub Issues](https://github.com/your-username/kiro-kb-skills/issues)
2. **创建新 Issue**: 详细描述问题和环境信息
3. **查看文档**: [完整文档](../README.md)
4. **社区讨论**: [GitHub Discussions](https://github.com/your-username/kiro-kb-skills/discussions)

---

**持续更新中...** 如果你有其他问题，欢迎提交 Issue 或 PR 来完善这个 FAQ！