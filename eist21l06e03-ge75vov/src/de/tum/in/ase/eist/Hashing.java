package de.tum.in.ase.eist;

public abstract class Hashing {

	private HashFunction implementation;

	public Hashing(HashFunction hashFunction) {
		implementation = hashFunction;
	}

	public HashFunction getImplementation() {
		return implementation;
	}

	public abstract String hashDocument(String string);
}
