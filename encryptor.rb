class Encryptor
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def encrypt(string, rotation)
    letters = string.split("")

    results = letters.collect do |letter|  
      encrypt_letter(letter, rotation)
    end
    
    results.join
  end

  def encrypt_file(filename, rotation)
    input = File.open(filename, "r")
    file_contents = input.read
    encrypted_contents = encrypt(file_contents, rotation)
    encrypted_file = filename + ".encrypted"
    output = File.open(encrypted_file, "w")
    output.write(encrypted_contents)
    output.close
  end

  def decipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(-1 * rotation)
    Hash[characters.zip(rotated_characters)]
  end

  def decrypt_letter(letter, rotation)
    decipher_for_rotation = decipher(rotation)
    decipher_for_rotation[letter]
  end

  def decrypt(string, rotation)
    letters = string.split("")

    results = letters.collect do |letter|
      decrypt_letter(letter, rotation)
    end

    results.join
  end
 
  def decrypt_file(filename, rotation)
    input = File.open(filename, "r")
    file_contents = input.read
    decrypted_contents = decrypt(file_contents, rotation)
    decrypted_file = filename.gsub("encrypted", "decrypted")
    output = File.open(decrypted_file, "w")
    output.write(decrypted_contents)
    output.close
  end

  def supported_characters
    (' '..'z').to_a
  end

  def crack(message)
    supported_characters.count.times.collect do |attempt|
      decrypt(message, attempt)
    end
  end
end
