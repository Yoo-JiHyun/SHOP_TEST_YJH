package shop.dao;

import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		int result = 0;
		String sql = "INSERT INTO order(order_no, cart_id, ship_name, zip_code, country, address, date, user_id, total_price, phone, order_pw)"
				   + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, order.getOrderNo());
			psmt.setString(2, order.getCartId());
			psmt.setString(3, order.getShipName());
			psmt.setString(4, order.getZipCode());
			psmt.setString(5, order.getCountry());
			psmt.setString(6, order.getAddress());
			psmt.setString(7, order.getDate());
			psmt.setString(8, order.getUserId());
			psmt.setInt(9, order.getTotalPrice());
			psmt.setString(10, order.getPhone());
			psmt.setString(11, order.getOrderPw());
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.err.println("주문 등록 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		
		int orderNo = 0;
		String sql = " SELECT MAX(order_no) "
				   + " AS last_order_no "
				   + " FROM orders";
		
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			if ( rs.next() ) {
				orderNo = rs.getInt("last_order_no");
			}
		} catch (Exception e) {
			System.err.println("최근 주문 번호 조회 중 예외 발생");
			e.printStackTrace();
		}
		return orderNo;
	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		List<Product> list = new ArrayList<>();

		String sql = " SELECT o.order_no "
					+ "	,p.name "
					+ "	,p.unit_price "
					+ " ,io.amount"
					+ " FROM `order` o JOIN product_io io ON o.order_no = io.order_no " 
					+ " JOIN product p ON io.product_id = p.product_id "
					+ " WHERE o.user_id =?";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, userId);
			rs = psmt.executeQuery();  // 데이터 조회 요청

			while( rs.next() ) {
				Product product = new Product();
				product.setOrderNo( rs.getInt("order_no") );
				product.setName( rs.getString("name") );
				product.setUnitPrice( rs.getInt("unit_price") );
				product.setQuantity( rs.getInt("Quantity") );
				product.setUserId( rs.getString("userId") );

				list.add(product); // 리스트에 항목 추가
			}
		} catch (Exception e) {
			System.err.println("주문 내역 조회 중 예외 발생");
			e.printStackTrace();
		}
		return list;
		
		
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		
		List<Product> list = new ArrayList<>();

		String sql = " SELECT o.order_no "
					+ "	,p.name "
					+ "	,p.unit_price "
					+ " ,io.amount"
					+ " FROM `order` o JOIN product_io io ON o.order_no = io.order_no " 
					+ " JOIN product p ON io.product_id = p.product_id "
					+ " WHERE o.phone =?"
					+ " AND o.order_pw =?";

		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, phone);
			psmt.setString(2, orderPw);
			rs = psmt.executeQuery();  // 데이터 조회 요청

			while( rs.next() ) {
				Product product = new Product();
				product.setOrderNo( rs.getInt("order_no") );
				product.setName( rs.getString("name") );
				product.setUnitPrice( rs.getInt("unit_price") );
				product.setQuantity( rs.getInt("Quantity") );

				list.add(product); // 리스트에 항목 추가
			}
		} catch (Exception e) {
			System.err.println("주문 내역 조회 중 에러 발생");
			e.printStackTrace();
		}
		return list;
	}
	
}






























