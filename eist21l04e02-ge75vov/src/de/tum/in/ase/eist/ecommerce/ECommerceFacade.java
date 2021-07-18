package de.tum.in.ase.eist.ecommerce;

public class ECommerceFacade {

	private AdvertisementController advertisementController;
	private OrderController orderController;
	private ShippingController shippingController;

	public ECommerceFacade() {
		advertisementController = new AdvertisementController();
		orderController = new OrderController();

		shippingController = new ShippingController();

	}

	public void playAdvertisement(int ageRestriction) {
		advertisementController.playAdvertisement(ageRestriction);

	}
//orkr
	public void processOrder(Order order) {
		orderController.processOrder(order);
	}

	public Order retrieveLatestOrder(int something) {
		return orderController.retrieveLatestOrder(something);
	}

	public void shipOrder(Order order, String address) {
		// order.setShipping(shippingController.createShipping(shippingAddress));
		Shipping s = shippingController.createShipping(address);

		order.setShipping(s);
		//orderController.processOrder(order);
		shippingController.shipOrder(order);
	}
}
