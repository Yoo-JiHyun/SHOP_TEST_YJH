package shop.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import shop.dto.Product;

public class ProductIORepository extends JDBConnection {

	/**
	 * 상품 입출고 등록
	 * @param product
	 * @param type
	 * @return
	 */
	public int insert(Product product) {
		
		int result = 0;
		
		String sql = "INSERT INTO product_io(order_no, product_id, amount, type, io_date, user_id)"
				   + " VALUES (?, ?, ?, ?, NOW(), ?)";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, product.getOrderNo());
			psmt.setString(2, product.getProductId());
			psmt.setInt(3, product.getAmount());
			psmt.setString(4, product.getType());
			psmt.setString(5, product.getUserId());
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("회원 등록 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	

}