source ~/.config/bash/bashrc
# OpenAI API Key (optional)
if [ -f ./openai_api_key ]; then
	export OPENAI_API_KEY="$(cat ./openai_api_key)"
fi
if [ -f ./ANTHROPIC_API_KEY ]; then
	export ANTHROPIC_API_KEY="$(cat "$HOME/ANTHROPIC_API_KEY")"
fi
if [ -f ./GEMINI_API_KEY ]; then
	export GEMINI_API_KEY="$(cat "$HOME/GEMINI_API_KEY")"
fi
