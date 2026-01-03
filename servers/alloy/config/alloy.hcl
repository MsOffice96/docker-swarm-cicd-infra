
// Docker 데몬에서 실행 중인 컨테이너 찿기
discovery.docker "services" {
        host = "unix:///var/run/docker.sock"
}

discovery.relabel "service_relabel" {

        targets = discovery.docker.services.targets

        // Stack 이름 추출
        rule {
          source_labels = ["__meta_docker_container_label_com_docker_stack_namespace"]
          target_label = "stack"
        }

        // Service 이름 추출
        rule {
          source_labels = ["__meta_docker_container_label_com_docker_swarm_service_name"]
          target_label = "service"
        }

        // Container 이름 추출
        rule {
          source_labels = ["__meta_docker_container_name"]
          target_label = "container_name"
        }

}

// 로그 수집
loki.source.docker "service_logs" {
        host       = "unix:///var/run/docker.sock"
        targets    = discovery.relabel.service_relabel.output
        forward_to = [loki.process.parse_logs.receiver]
}

// 로그 가공
loki.process "parse_logs" {
        forward_to = [loki.write.grafana_loki.receiver]

        // ANSI 색상 코드 제거
        stage.decolorize {}

        // 로그에서 레벨
        stage.regex {
          expression = "^(?P<time>\\S+ \\S+)\\s+(?P<thread>\\[.+?\\])\\s+(?P<level>[A-Z]+)\\s+(?P<rest>.*)$"
        }

        // 추출한 'level'을 Loki의 정식 라벨로 등록
        stage.labels {
          values = {
            level = "level",
          }
        }

        stage.timestamp{
          source = "time"
          format = "2025-01-01 10:10:10.000"
        }
}

// 수집한 로그 전달
loki.write "grafana_loki" {
        endpoint {
          url = "http://host.docker.internal:3100/loki/api/v1/push"
        }
}