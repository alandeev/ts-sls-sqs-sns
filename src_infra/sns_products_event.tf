resource "aws_sns_topic" "products_events" {
  name = "products-events"
}

resource "aws_sns_topic_subscription" "sns_products_events" {
  topic_arn = aws_sns_topic.products_events.arn
  protocol = "sqs"
  endpoint = aws_sqs_queue.logs_events_queue.arn

  depends_on = [
    aws_sns_topic.products_events,
    aws_sqs_queue.logs_events_queue
  ]
}
