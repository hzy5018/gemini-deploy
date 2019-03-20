# deploy gemini-system

## poc 部署

```reStructuredText
.
├── README.md 
├── deploy-offline.sh # 离线部署脚本
├── deploy.sh # 在线部署脚本
├── docker-compose.yml # 容器编排脚本
├── images # 镜像制作目录，并且保存成镜像文件
│   ├── edgenode # 重制edgenode镜像，添加gemini-offline-web(离线任务调度服务)
│   │   └── Dockerfile
│   ├── gemini # gemini 镜像
│   │   └── Dockerfile
│   └── postgresql # 执行gemini.sql
│       ├── Dockerfile
│       └── gemini.sql
├── save.sh
└── software # docker 安装软件、java安装软件主要用于离线
```
docker pull 10.72.100.25:5000/gemini-graph:1.0
