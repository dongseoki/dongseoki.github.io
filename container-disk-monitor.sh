#!/bin/bash

echo "=== Container Disk Usage Details ==="
docker ps --format "{{.Names}}" | while read container; do
    echo "Container: $container"
    echo "Size details:"
    docker ps -s --filter "name=$container" --format "Virtual Size: {{.Size}}"
    echo "Top 5 largest directories:"
    docker exec $container du -h / 2>/dev/null | sort -hr | head -n 5
    echo "------------------------"
done
