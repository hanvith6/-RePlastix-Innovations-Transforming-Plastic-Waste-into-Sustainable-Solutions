public class InventoryManager {

    public static void processOrderStock(List<Re_Plastic_Innovations_Order__c> orderList) {
        Set<Id> productIds = new Set<Id>();
        for (Re_Plastic_Innovations_Order__c order : orderList) {
            productIds.add(order.Recycled_Product__c);
        }

        Map<Id, Re_Plastic_Innovations_Recycled_Product__c> productMap = new Map<Id, Re_Plastic_Innovations_Recycled_Product__c>(
            [SELECT Id, Stock_Level__c, Threshold__c FROM Re_Plastic_Innovations_Recycled_Product__c WHERE Id IN :productIds]
        );

        List<Re_Plastic_Innovations_Recycled_Product__c> productsToUpdate = new List<Re_Plastic_Innovations_Recycled_Product__c>();
        List<Re_Plastic_Innovations_Restock_Request__c> restockRequests = new List<Re_Plastic_Innovations_Restock_Request__c>();

        for (Re_Plastic_Innovations_Order__c order : orderList) {
            Re_Plastic_Innovations_Recycled_Product__c product = productMap.get(order.Recycled_Product__c);
            if (product != null) {
                if (product.Stock_Level__c >= order.Quantity__c) {
                    product.Stock_Level__c -= order.Quantity__c;
                    productsToUpdate.add(product);
                } else {
                    restockRequests.add(new Re_Plastic_Innovations_Restock_Request__c(
                        Product__c = product.Id,
                        Requested_Quantity__c = order.Quantity__c - product.Stock_Level__c,
                        Status__c = 'Pending'
                    ));
                }
            }
        }

        if (!productsToUpdate.isEmpty()) update productsToUpdate;
        if (!restockRequests.isEmpty()) insert restockRequests;
    }

    public static void processRestockApproval(List<Re_Plastic_Innovations_Restock_Request__c> restockList) {
        Set<Id> productIds = new Set<Id>();
        for (Re_Plastic_Innovations_Restock_Request__c restock : restockList) {
            if (restock.Status__c == 'Approved') {
                productIds.add(restock.Product__c);
            }
        }

        Map<Id, Re_Plastic_Innovations_Recycled_Product__c> productMap = new Map<Id, Re_Plastic_Innovations_Recycled_Product__c>(
            [SELECT Id, Stock_Level__c FROM Re_Plastic_Innovations_Recycled_Product__c WHERE Id IN :productIds]
        );

        List<Re_Plastic_Innovations_Recycled_Product__c> productsToUpdate = new List<Re_Plastic_Innovations_Recycled_Product__c>();

        for (Re_Plastic_Innovations_Restock_Request__c restock : restockList) {
            if (productMap.containsKey(restock.Product__c)) {
                Re_Plastic_Innovations_Recycled_Product__c product = productMap.get(restock.Product__c);
                product.Stock_Level__c += restock.Requested_Quantity__c;
                productsToUpdate.add(product);
            }
        }

        if (!productsToUpdate.isEmpty()) update productsToUpdate;

        EmailNotificationHelper.sendRestockNotification(restockList);
    }
}