class User < ApplicationRecord
  has_secure_password
  before_validation :verificacao_de_idade
  validates :name, :email, :cep, :phone, :birth_date, presence: true

  validates :name,
  length: { maximum: 250 },
  format: { with: /\A[a-zA-Z\s]+\z/, message: "deve conter apenas letras e espaços." },
  uniqueness: { case_sensitive: false, message: "Este usuário já está em uso." }

  validates :password,
  length: { minimum: 8 }, if: -> { new_record? || !password.nil? }

  validates :cep,
  length: { minimum: 8, maximum: 8 },
  numericality: { only_integer: true, message: "deve conter apenas números" }

  validates :phone,
  length: { minimum: 13, maximum: 15 },
  numericality: { only_integer: true, message: "deve conter apenas números" },
  uniqueness: { case_sensitive: false, message: "Este número de telefon já pertence a uma conta." }

  validates :email,
  length: { maximum: 250 },
  format: { with: URI::MailTo::EMAIL_REGEXP, message: "deve ser um endereço de e-mail válido" },
  uniqueness: { case_sensitive: false, message: "Este e-mail já está em uso." }

  def verificacao_de_idade
    if birth_date.present? && (birth_date > 18.years.ago.to_date || birth_date > Date.today)
      errors.add(:birth_date, "O usuário deve ter pelo menos 18 anos e não pode ter uma data de nascimento futura.")
    end
  end
end

    t.string "name"
    t.string "email"
    t.string "cep"
    t.string "phone"
    t.date "birth_date"
