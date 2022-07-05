class User < ApplicationRecord
    #callback to ensure that session token is present
    after_initialize :ensure_session_token

    #Validations
    validates :username, :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: { minimum: 6 }, allow_nil: true

    attr_reader :password 

    #Matching the user that we want correctly
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.check_password?(password)
            user
        else
            nil
        end
    end

    #This is checking to see if the password in the database matches our password?
    def check_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end

    #Setting password using the BCrypt Hashing Method
    def password=(password)
        # puts "setter being called"
        @password = password

        self.password_digest = BCrypt::Password.create(password)
    end

    #Reset Session Token
    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end
end