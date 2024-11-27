# config.sh

# Default values
namespace=kong
helm_name=kong

# Extract from arguments
for arg in "$@"; do
  # namespace argument (-ns)
  case $arg in
    -n=* )
      namespace="${arg#*=}"  # Extract the value after '='
      ;;
  esac
  # helm name argument (-hn)
  case $arg in
    -h=* )
      helm_name="${arg#*=}"  # Extract the value after '='
      ;;
  esac
done
