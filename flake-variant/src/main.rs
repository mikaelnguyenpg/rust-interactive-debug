use std::sync::{Arc, Mutex};

#[derive(Debug)]
enum UserRole {
    Admin(u32), // Tuple variant
    Guest,      // Unit variant
}

#[allow(unused_variables, dead_code)]
fn test() {
    // --- A. String và Vec (Owned) ---
    let name = String::from("Michael");
    let scores = vec![10, 20, 30, 40];

    // --- B. &str và &[T] (Slices) ---
    let name_slice = &name[0..4]; // "Mich"
    let scores_slice = &scores[1..3]; // [20, 30]

    // --- C. Enum (Option và Custom) ---
    let some_val = Some(100);
    let none_val: Option<i32> = None;
    let role_admin = UserRole::Admin(99);
    let role_guest = UserRole::Guest;

    // --- D. Smart Pointers (Arc & Mutex) ---
    // Đây chính là cấu trúc "bom nổ chậm" trong db.rs của bạn
    let shared_data = Arc::new(Mutex::new(vec![1, 2, 3]));

    println!("Đặt breakpoint ở dòng này và bắt đầu quan sát!"); // <--- BREAKPOINT HERE
}

fn main() {
    test();
    
    println!("Hello, world!");
}
