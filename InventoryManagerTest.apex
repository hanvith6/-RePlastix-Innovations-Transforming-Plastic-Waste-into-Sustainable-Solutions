@isTest
public class InventoryManagerTest {

    @testSetup
    static void setupTestData() {
        Re_Plastic_Innovations_Recycled_Product__c product = new Re_Plastic_Innovations_Recycled_Product__c(
            Stock_Level__c = 50,
            Threshold__c = 10
        );
        insert product;

        List<Re_Plastic_Innovations_Order__c> orders = new List<Re_Plastic_Innovations_Order__c>{
            new Re_Plastic_Innovations_Order__c(Recycled_Product__c = product.Id, Quantity__c = 20),
            new Re_Plastic_Innovations_Order__c(Recycled_Product__c = product.Id, Quantity__c = 40)
        };
        insert orders;
    }

    @isTest
    static void testProcessOrderStock() {
        List<Re_Plastic_Innovations_Order__c> orders = [
            SELECT Id, Recycled_Product__c, Quantity__c 
            FROM Re_Plastic_Innovations_Order__c
        ];

        Test.startTest();
        InventoryManager.processOrderStock(orders);
        Test.stopTest();

        Re_Plastic_Innovations_Recycled_Product__c product = [
            SELECT Stock_Level__c 
            FROM Re_Plastic_Innovations_Recycled_Product__c 
            LIMIT 1
        ];
        System.assertEquals(10, product.Stock_Level__c);

        List<Re_Plastic_Innovations_Restock_Request__c> restocks = [
            SELECT Id 
            FROM Re_Plastic_Innovations_Restock_Request__c 
            WHERE Status__c = 'Pending'
        ];
        System.assertEquals(1, restocks.size());
    }

    @isTest
    static void testProcessRestockApproval() {
        List<Re_Plastic_Innovations_Restock_Request__c> restocks = [
            SELECT Id, Product__c, Requested_Quantity__c 
            FROM Re_Plastic_Innovations_Restock_Request__c
        ];
        for (Re_Plastic_Innovations_Restock_Request__c req : restocks) {
            req.Status__c = 'Approved';
        }
        update restocks;

        Re_Plastic_Innovations_Recycled_Product__c productBefore = [
            SELECT Stock_Level__c 
            FROM Re_Plastic_Innovations_Recycled_Product__c 
            LIMIT 1
        ];
        Decimal initialStock = productBefore.Stock_Level__c;

        Decimal totalRestockQuantity = 0;
        for (Re_Plastic_Innovations_Restock_Request__c req : restocks) {
            totalRestockQuantity += req.Requested_Quantity__c;
        }

        Test.startTest();
        InventoryManager.processRestockApproval(restocks);
        Test.stopTest();

        Re_Plastic_Innovations_Recycled_Product__c productAfter = [
            SELECT Stock_Level__c 
            FROM Re_Plastic_Innovations_Recycled_Product__c 
            LIMIT 1
        ];
        Decimal expectedStock = initialStock + totalRestockQuantity;
        System.assertEquals(expectedStock, productAfter.Stock_Level__c);
    }
}