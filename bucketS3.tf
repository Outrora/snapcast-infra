resource "aws_s3_bucket" "bucket_snapcast" {
  bucket = "${var.NOME}videos"  # Troque para um nome globalmente único


  tags = {
    Name        = "Meu bucket exemplo"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "libera_para_principal" {
  bucket = aws_s3_bucket.bucket_snapcast.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Sid: "PermitirAcessoS3ParaPrincipalArn",
        Effect: "Allow",
        Principal: {
          AWS = "${var.principalArn}"  # <-- seu PrincipalArn aqui
        },
        Action: [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource: [
          "${aws_s3_bucket.bucket_snapcast.arn}/*"
        ]
      }
    ]
  })
}