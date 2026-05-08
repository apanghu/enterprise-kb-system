# 贡献指南

感谢你对 Kiro Knowledge Base Skills 项目的关注！我们欢迎各种形式的贡献。

## 🤝 如何贡献

### 报告 Bug

如果你发现了 bug，请：

1. 检查 [Issues](https://github.com/your-username/kiro-kb-skills/issues) 确认问题未被报告
2. 创建新的 Issue，包含：
   - 清晰的标题和描述
   - 重现步骤
   - 预期行为 vs 实际行为
   - 环境信息（操作系统、Python 版本等）
   - 相关日志或截图

### 建议新功能

1. 创建 Feature Request Issue
2. 描述功能的用途和价值
3. 提供使用场景示例
4. 讨论实现方案

### 提交代码

1. **Fork 仓库**
   ```bash
   git clone https://github.com/your-username/kiro-kb-skills.git
   cd kiro-kb-skills
   ```

2. **创建功能分支**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **进行开发**
   - 遵循代码规范
   - 添加必要的测试
   - 更新文档

4. **提交更改**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

5. **推送分支**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **创建 Pull Request**

## 📝 代码规范

### Python 代码规范

- 遵循 [PEP 8](https://pep8.org/) 规范
- 使用 4 个空格缩进
- 行长度不超过 88 字符
- 使用有意义的变量和函数名

### 文档字符串

```python
def example_function(param1: str, param2: int) -> bool:
    """
    函数的简短描述
    
    Args:
        param1: 参数1的描述
        param2: 参数2的描述
    
    Returns:
        返回值的描述
    
    Raises:
        ValueError: 异常情况的描述
    """
    pass
```

### 提交信息规范

使用 [Conventional Commits](https://www.conventionalcommits.org/) 格式：

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

类型：
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `style`: 代码格式化
- `refactor`: 代码重构
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动

示例：
```
feat(kb-reader): add hybrid search functionality

Add support for combining vector and keyword search
to improve search accuracy and recall.

Closes #123
```

## 🧪 测试

### 运行测试

```bash
# 测试 kb-manager
cd kb-manager
python -m pytest tests/

# 测试 kb-reader
cd kb-reader
python -m pytest tests/
```

### 编写测试

- 为新功能添加单元测试
- 确保测试覆盖率 > 80%
- 使用描述性的测试名称

```python
def test_should_return_relevant_documents_when_query_matches():
    # Given
    query = "测试查询"
    
    # When
    results = reader.query(query)
    
    # Then
    assert len(results) > 0
    assert "相关内容" in results[0]
```

## 📚 文档

### 更新文档

- 为新功能添加文档
- 更新 README.md 中的功能列表
- 更新 SKILL.md 中的使用说明
- 添加配置选项说明

### 文档格式

- 使用 Markdown 格式
- 添加适当的标题层级
- 使用代码块展示示例
- 添加表情符号增加可读性

## 🔍 代码审查

### Pull Request 要求

- [ ] 代码遵循项目规范
- [ ] 添加了必要的测试
- [ ] 测试全部通过
- [ ] 更新了相关文档
- [ ] 提交信息清晰明确
- [ ] 没有引入破坏性变更

### 审查流程

1. 自动化检查（CI/CD）
2. 代码审查（至少一个维护者）
3. 测试验证
4. 合并到主分支

## 🚀 发布流程

### 版本号规范

使用 [Semantic Versioning](https://semver.org/)：

- `MAJOR.MINOR.PATCH`
- MAJOR: 不兼容的 API 变更
- MINOR: 向后兼容的功能性新增
- PATCH: 向后兼容的问题修正

### 发布检查清单

- [ ] 更新版本号
- [ ] 更新 CHANGELOG.md
- [ ] 创建 Git 标签
- [ ] 发布 GitHub Release
- [ ] 更新文档

## 🛠️ 开发环境设置

### 本地开发

1. **克隆仓库**
   ```bash
   git clone https://github.com/your-username/kiro-kb-skills.git
   cd kiro-kb-skills
   ```

2. **创建虚拟环境**
   ```bash
   python -m venv venv
   source venv/bin/activate  # Linux/Mac
   # 或
   venv\Scripts\activate     # Windows
   ```

3. **安装依赖**
   ```bash
   cd kb-manager
   pip install -r requirements.txt
   pip install -r requirements-dev.txt  # 开发依赖
   
   cd ../kb-reader
   pip install -r requirements.txt
   pip install -r requirements-dev.txt
   ```

4. **配置环境变量**
   ```bash
   export DASHSCOPE_API_KEY='your-test-api-key'
   ```

5. **运行测试**
   ```bash
   python -m pytest
   ```

### 开发工具

推荐使用的开发工具：

- **IDE**: VS Code, PyCharm
- **代码格式化**: black, isort
- **代码检查**: flake8, pylint
- **类型检查**: mypy
- **测试**: pytest

### 预提交钩子

安装 pre-commit 钩子：

```bash
pip install pre-commit
pre-commit install
```

## 📞 获取帮助

如果你在贡献过程中遇到问题：

1. 查看现有的 Issues 和 Discussions
2. 在 Discussions 中提问
3. 联系维护者
4. 加入社区群组

## 🙏 致谢

感谢所有贡献者的努力！你的贡献让这个项目变得更好。

---

**Happy Coding!** 🎉