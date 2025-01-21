# config.sh

# Default values
namespace=apk
helm_apim_name=apim
helm_agent_name=apim-agent

# Extract from arguments
for arg in "$@"; do
  # namespace argument (-ns)
  case $arg in
    -n=* )
      namespace="${arg#*=}"  # Extract the value after '='
      ;;
  esac
  # helm name argument (-h_apim)
  case $arg in
    -h_apim=* )
      helm_apim_name="${arg#*=}"  # Extract the value after '='
      ;;
  esac
  # helm name argument (-h_agent)
  case $arg in
    -h_agent=* )
      helm_agent_name="${arg#*=}"  # Extract the value after '='
      ;;
  esac
done
