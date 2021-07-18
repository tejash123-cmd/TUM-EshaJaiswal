package de.tum.in.ase.eist.presentationlayer;

import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import de.tum.in.ase.eist.applicationlayer.ApplicationLayerInterface;
import de.tum.in.ase.eist.networklayer.NetworkLayerInterface;

/**
 * Code from Stackoverflow.
 * http://stackoverflow.com/questions/15554296/simple-java-aes-encrypt-decrypt-example
 */
public class AesEncryption extends ChatEncryption implements PresentationLayerInterface {

	private static final byte[] INIT_VECTOR = "RandomInitVector".getBytes(StandardCharsets.UTF_8);
//tried to complete the task
	// TODO: Part 3: Conform to the interface PresentationLayerInterface and pass
	// the method calls to the application layer or network layer
	// TODO: Part 3: Add references to ApplicationLayerInterface and
	// NetworkLayerInterface
	private ApplicationLayerInterface applicationLayer;
	private NetworkLayerInterface networkLayer;
	private final byte[] key;

	public AesEncryption(String key) {
		this.key = key.getBytes(StandardCharsets.UTF_8);
	}

	@Override
	public String encrypt(String message) {
		try {
			IvParameterSpec iv = new IvParameterSpec(INIT_VECTOR);
			SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");

			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
			cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);

			byte[] encrypted = cipher.doFinal(message.getBytes(StandardCharsets.UTF_8));
			return Base64.getEncoder().encodeToString(encrypted);
		} catch (RuntimeException | GeneralSecurityException ex) {
			ex.printStackTrace();
		}

		return "Errors in encryption.";
	}

	@Override
	public String decrypt(String message) {
		// handle special cases that are sent unencrypted
		if (this.isServerMessage(message)) {
			return message;
		}
		String serverPrefix = findServerPrefix(message);
		String encryptedMessage = findEncryptedMessage(message);
		try {
			IvParameterSpec iv = new IvParameterSpec(INIT_VECTOR);
			SecretKeySpec skeySpec = new SecretKeySpec(key, "AES");

			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
			cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);

			byte[] original = cipher.doFinal(Base64.getDecoder().decode(encryptedMessage));
			return serverPrefix + new String(original, StandardCharsets.UTF_8);
		} catch (RuntimeException | GeneralSecurityException ex) {
			ex.printStackTrace();
		}
		return "Errors in decryption.";
	}

	@Override
	public void start() {
		// TODO Auto-generated method stub
		networkLayer.openConnection();
	}

	@Override
	public void stop() {
		// TODO Auto-generated method stub
		networkLayer.closeConnection();
	}

	@Override
	public void sendMessage(String message) {
		// TODO Auto-generated method stub
		String result = encrypt(message);
		networkLayer.sendMessage(result);
	}

	@Override
	public void receiveMessage(String message) {
		// TODO Auto-generated method stub
		String result = decrypt(message);
		applicationLayer.receiveMessage(result);
	}

	@Override
	public void setNetworkLayer(NetworkLayerInterface networkLayer) {
		// TODO Auto-generated method stub
		this.networkLayer = networkLayer;

	}

	@Override
	public NetworkLayerInterface getNetworkLayer() {
		// TODO Auto-generated method stub
		return networkLayer;
	}

	@Override
	public void setApplicationLayer(ApplicationLayerInterface applicationLayer) {
		// TODO Auto-generated method stub
		this.applicationLayer = applicationLayer;

	}

	@Override
	public ApplicationLayerInterface getApplicationLayer() {
		// TODO Auto-generated method stub
		return applicationLayer;
	}

	// TODO: Part 3: The send message method must encrypt the message before sending
	// TODO: Part 3: The receive message method must decrypt the message before
	// giving it to upper layer

}
