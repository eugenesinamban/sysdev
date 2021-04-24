# lcl

alias sysdev-lcl-build="docker-compose build php-fpm lcl"
alias sysdev-lcl="sysdev-lcl-build && docker-compose up lcl"
alias sysdev-lcl-d="sysdev-lcl-build && docker-compose up -d lcl"
alias sysdev-lcl-logs="docker-compose logs -f --tail 100 lcl"
alias sysdev-lcl-restart="docker-compose restart lcl"
alias sysdev-lcl-db-bash="docker-compose exec db bash"
alias sysdev-lcl-bash="docker-compose exec lcl bash"

# prd
alias sysdev-prd="sysdev-prd-build && docker-compose up -d prd"
alias sysdev-prd-bash="docker-compose exec prd bash"

alias sysdev-prd-push=" \
    docker tag sysdev_prd codejunkie21/sysdev_prd:latest && \
    docker push codejunkie21/sysdev_prd:latest
"
# deploy
alias sysdev-prd-deploy="sysdev-prd-build && sysdev-prd-push"

function sysdev-prd-build() {
  git fetch origin master
  ORIGIN_MASTER=$(git show-ref origin/master -s)
  CURRENT=$(git rev-parse HEAD)
  if [[ "$ORIGIN_MASTER" != "$CURRENT" ]]; then
    echo 'origin/master と一致していないのでビルドできません';

    # return error
    return 1
  else
    echo 'git diff をチェックしてビルドします。コミットされてなければビルドできません';
    git diff --exit-code && \
    git diff --staged --exit-code && \
    docker-compose build php-fpm prd
  fi
}
