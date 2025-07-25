source ~/.config/bash/bashrc
# OpenAI API Key (optional)
if [ -f ./openai_api_key ]; then
    export OPENAI_API_KEY="$(cat ./openai_api_key)"
fi
