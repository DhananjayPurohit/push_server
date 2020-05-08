import Config

config :web_push_encryption, :vapid_details,
  subject: "mailto:administrator@example.com",
  public_key: "PUBLIC_VAPID_KEY",
  private_key: "PRIVATE_VAPID_KEY"
