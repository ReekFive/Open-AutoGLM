#!/bin/bash
# Open-AutoGLM 交互式运行脚本
# 使用智谱 BigModel API
# 
# 使用方法: 
#   ./run.sh                    # 进入交互模式
#   ./run.sh "任务描述"          # 执行单个任务

# 智谱 BigModel API 配置
API_KEY="XXXXXXXXXXXXXXXXXXXXX"
BASE_URL="https://open.bigmodel.cn/api/paas/v4"
MODEL="autoglm-phone"
PYTHON="/opt/miniconda3/envs/Open-AutoGLM/bin/python"

echo "=========================================="
echo "🤖 Open-AutoGLM 手机智能助手"
echo "=========================================="
echo "🌐 API: 智谱 BigModel"
echo "📱 模型: $MODEL"
echo "=========================================="

cd "$(dirname "$0")"

if [ -n "$1" ]; then
    # 单任务模式
    echo "📱 执行任务: $1"
    echo ""
    $PYTHON main.py \
        --base-url "$BASE_URL" \
        --model "$MODEL" \
        --apikey "$API_KEY" \
        "$1"
else
    # 交互模式
    echo "💬 进入交互模式 (输入 'quit' 或 'exit' 退出)"
    echo ""
    
    while true; do
        echo -n "🎯 请输入任务: "
        read -r TASK
        
        # 检查退出命令
        if [ "$TASK" = "quit" ] || [ "$TASK" = "exit" ] || [ "$TASK" = "q" ]; then
            echo "👋 再见!"
            break
        fi
        
        # 跳过空输入
        if [ -z "$TASK" ]; then
            continue
        fi
        
        echo ""
        echo "⏳ 正在执行任务..."
        echo "------------------------------------------"
        
        $PYTHON main.py \
            --base-url "$BASE_URL" \
            --model "$MODEL" \
            --apikey "$API_KEY" \
            "$TASK"
        
        echo ""
        echo "=========================================="
        echo ""
    done
fi
