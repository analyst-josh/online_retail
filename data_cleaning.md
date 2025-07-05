GitHub 

##  How This Pipeline Was Developed
  
oultine of steps:

---

###  Data Loading and Merging
- Imported two separate Excel sheets (`Year 2009-2010`, `Year 2010-2011`).
- Merged them into a single DataFrame with `pd.concat()`.

---

###  Initial Exploration
- Previewed with `.head()` and `.info()`.
- checked column names and renamed them to be snake_case and for easier access (`invoice_id`, `stock_id`, etc.).
- checked unique prefixes in `invoice_id` to understand transaction patterns.

---

###  Standardization
- Converted all IDs (`invoice_id`, `stock_id`) to string and removed spaces.
- Trimmed description fields.

---

###  Identifying Data Issues
- Noticed rows where:
  - `invoice_id` started with `C` (credit notes) and always had negative quantity.
  - Some descriptions were only `?`.
  - Some descriptions began with `*` (noise).
  - Negative prices only occurred with `adjust bad debt` transactions.
  - Numeric `invoice_id` rows with negative quantity and 0 price, and no customer, appeared to be inventory corrections.

---

###  Classifying Transactions
- Defined initial `transaction_type = "sale"` for all rows.
- Added classification for:
  - Credit notes: invoices starting with `C`
  - Inventory corrections: negative quantity, zero price, no customer ID
  - Unknown items: description full of `?`
  - Adjust bad debt: `stock_id = B`
  - Other special cases: mapped specific `stock_id` values to descriptive labels.

---

###  Handling Missing Descriptions
- Built a `desc_map` by mapping known `stock_id` values to descriptions.
- Used `.map()` to fill missing descriptions.

---

###  Cleaning Descriptions
- Removed rows where description started with `*`.
- Trimmed all description fields.

---

###  Validating Data
- Ran `.value_counts()` on `transaction_type` to confirm classification counts.
- Checked for remaining nulls and unexpected negative prices.
- Verified no duplicate rows remained.

---

###  Exporting Clean Data
- Saved cleaned data to CSV for further analysis in SQL.

---








