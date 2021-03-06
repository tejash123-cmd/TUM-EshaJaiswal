package de.tum.in.ase.eist.presentationlayer;

import de.tum.in.ase.eist.applicationlayer.ApplicationLayerInterface;
import de.tum.in.ase.eist.networklayer.NetworkLayerInterface;

public class CaesarEncryption extends ChatEncryption implements PresentationLayerInterface {

	// TODO: Part 2: Conform to the interface PresentationLayerInterface and pass
	// the method calls to the application layer or network layer
	// TODO: Part 2: Add references to ApplicationLayerInterface and
	// NetworkLayerInterface
	private ApplicationLayerInterface applicationLayer;
	private NetworkLayerInterface networkLayer;

	private static final int ALPHABET_SIZE = 26;

	private final int key;

	public CaesarEncryption(int key) {
		if (key <= 0 || key >= ALPHABET_SIZE) {
			throw new IllegalArgumentException("The key must have a value between 1 to 25");
		}
		this.key = key;
	}

	@Override
	public String encrypt(String message) {
		return shift(message, key);
	}

	@Override
	public String decrypt(String message) {
		// handle special cases that are sent unencrypted
		if (this.isServerMessage(message)) {
			return message;
		}
		return findServerPrefix(message) + shift(findEncryptedMessage(message), ALPHABET_SIZE - key);
	}

	private static String shift(String message, int key) {
		StringBuilder result = new StringBuilder();
		for (char character : message.toCharArray()) {
			if (character >= 'A' && character <= 'Z') {
				character = shift('A', character, key);
			} else if (character >= 'a' && character <= 'z') {
				character = shift('a', character, key);
			}
			result.append(character);
		}
		return result.toString();
	}

	private static char shift(char offset, char input, int key) {
		return (char) (offset + (input - offset + key) % ALPHABET_SIZE);
	}

	@Override
	public void start() {
		networkLayer.openConnection();

	}

	@Override
	public void stop() {
		networkLayer.closeConnection();
	}

	@Override
	public void sendMessage(String message) {
		String result = encrypt(message);
		networkLayer.sendMessage(result);
	}

	// TODO: Part 2: The send message method must encrypt the message before sending
	// TODO: Part 2: The receive message method must decrypt the message before
	// giving it to upper layer

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

}
