package de.tum.in.ase.eist;

public class PreviewHashing extends Hashing {
	public static final int MAX_INPUT_LENGTH = 1000;

	public PreviewHashing() {
		super(new SimpleHashAlgorithm());
	}

	@Override
	public String hashDocument(String string) {

		if (string.length() > MAX_INPUT_LENGTH) {
			throw new IllegalArgumentException("Preview version is not used for real exams");

		} else {
			return getImplementation().calculateHashCode(string);
		}
	}
}
