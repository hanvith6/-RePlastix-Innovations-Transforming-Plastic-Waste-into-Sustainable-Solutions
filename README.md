♻️ RePlastix Innovations – Salesforce Inventory Automation

This project demonstrates how RePlastix Innovations leverages Salesforce CRM to automate recycled plastic inventory management using Apex, Triggers, and Flows. The implementation helps prevent stock shortages, streamline restocking, and enhance cross-team communication through email automation.

---

## 📁 Project Structure

* 📄 InventoryManager.apex – Core Apex class for handling stock reduction and restock approval logic.
* 📄 UpdateStockAfterOrder.trigger – Trigger to handle order-based stock deduction.
* 📄 UpdateStockAfterRestockApproval.trigger – Trigger to handle restock updates and notify stakeholders.
* 📄 EmailNotificationHelper.apex – Sends email notifications to warehouse team upon restock approval.
* 🧪 InventoryManagerTest.apex – Test class covering 100% of logic with realistic order/restock scenarios.
* 📄 Salesforce\_Project\_Documentation.docx – Complete technical and functional documentation including ER diagram, UI walkthrough, use case, security model, and screenshots.

---

## 💡 Use Case

1. A Sales Rep places a new order.
2. The system checks stock availability:

   * If stock is enough → deducts quantity.
   * If stock is low → automatically creates a Restock Request.
3. A Manager approves the Restock Request.
4. The system:

   * Updates stock.
   * Sends an email to the warehouse team.

---

## ⚙️ Technologies Used

* Salesforce Apex Classes & Triggers
* Process Automation with Flows
* Role-based Security (FLS, CRUD)
* Developer Console & Change Sets
* Test Coverage: ✅ 100%

---

## 📸 Documentation Includes

* Entity Relationship (ER) Diagram
* UI Screenshots (Order, Product, Restock)
* Trigger/Flow Code
* Test Results & Deployment Logs
* Business Use Case & Phase-wise Implementation

---

## 🚀 How to Deploy

1. Clone this repository.
2. Authenticate your Salesforce org using:

```bash
sfdx auth:web:login -a RePlastixDev
```

3. Deploy using:

```bash
sfdx force:source:deploy -p force-app
```

4. Run Tests:

```bash
sfdx force:apex:test:run --resultformat human --outputdir test-results
```

---

## 👤 Author

**Hanvith Reddy B**
Salesforce Developer @ RePlastix Innovations
[LinkedIn](https://www.linkedin.com/in/hanvith-reddy-a67857252/) | [GitHub](https://github.com/hanvith6)

---

Let me know if you want me to auto-generate the README.md file in Markdown or include a badge (e.g., test coverage, build passing, etc.).
