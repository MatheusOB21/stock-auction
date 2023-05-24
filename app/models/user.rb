class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lots
  
  has_many :user_aprovateds

  has_many :user_bid_lots

  has_many :questions

  has_many :answers

  has_many :favorites


  #Validaçoes
  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validates :cpf, length:{ is: 11 }
  
  validate :cpf_is_valid
  validate :cpf_is_block

  def is_admin
    self.email =~ /\w+@leilaodogalpao.com.br/ ? true : false
  end

  def have_in_favorites?(lot_id)
    self.favorites.where(lot_id: lot_id).present?
  end

  def block?
    Blacklist.all.find_by(cpf: self.cpf) ? true : false
  end

  private

  def cpf_is_block
    if self.block?
      self.errors.add(:cpf, 'bloqueado pela administração. Não pode criar conta!')
    end
  end

  def cpf_is_valid
    if self.cpf_check
    else
      self.errors.add(:cpf, 'é inválido')
    end
  end
  
  def cpf_check
    cpf = self.cpf.split(//)
    
    #checagem do primeiro digito
    i1 = 11
    check1 = cpf[0..8]
    check1.map!{|dig|
    i1 = i1 - 1
    dig.to_i * i1
    }
    
    #checagem do segundo digito
    i2 = 12
    check2 = cpf[0..9]
    check2.map!{|dig|
    i2 = i2 - 1
    dig.to_i * i2
    }

    if 11 - (check1.sum%11) >= 10
      result1 = cpf[9].to_i == 0
    else
      result1 = cpf[9].to_i == (11 - (check1.sum%11))
    end

    if 11 - (check2.sum%11) >= 10
      result2 = cpf[10].to_i == 0
    else
      result2 = cpf[10].to_i == (11 - (check2.sum%11))
    end

    
    if result1 && result2 == true
      true
    else
      false
    end

  end


end
