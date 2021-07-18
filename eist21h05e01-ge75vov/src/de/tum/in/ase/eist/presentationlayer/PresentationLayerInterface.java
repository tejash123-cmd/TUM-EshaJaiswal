package de.tum.in.ase.eist.presentationlayer;

import de.tum.in.ase.eist.applicationlayer.ApplicationLayerInterface;
import de.tum.in.ase.eist.networklayer.NetworkLayerInterface;

public interface PresentationLayerInterface {

	// TODO: Part 2: Add setters and getters for neighboring layers. Add other
	// methods according to UML model.
	void start();

	void stop();

	void sendMessage(String message);

	void receiveMessage(String message);

	void setNetworkLayer(NetworkLayerInterface networkLayer);

	NetworkLayerInterface getNetworkLayer();

	void setApplicationLayer(ApplicationLayerInterface applicationLayer);

	ApplicationLayerInterface getApplicationLayer();

}
