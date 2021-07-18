package de.tum.in.ase.eist.applicationlayer;

import de.tum.in.ase.eist.presentationlayer.PresentationLayerInterface;

public interface ApplicationLayerInterface {

	void start();

	void stop();

	void sendMessage(String message);

	void receiveMessage(String message);

	void setPresentationLayer(PresentationLayerInterface presentationLayer);

	PresentationLayerInterface getPresentationLayer();

}
