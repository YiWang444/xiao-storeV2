package com.example.shopping_system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.shopping_system.dto.ProductDTO;
import com.example.shopping_system.pojo.Product;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;


import java.util.List;

@Mapper
public interface ProductMapper extends BaseMapper<Product> {


    @Select("select product_id, product_name, product_title, product_intro, product_price, product_selling_price, product_num, product_sales, product_picture, c.category_id from product\n" +
            "    join category c on product.category_id = c.category_id\n" +
            "    where c.category_id = ${categoryID} and product.deleted = 1\n" +
            "    limit ${currentPage}, ${pageSize}")
    List<ProductDTO> selectListOfDTO(Integer categoryID, Integer currentPage, Integer pageSize);

    @Select("select count(*) from product\n" +
            "    join category c on product.category_id = c.category_id\n" +
            "    where c.category_id = ${categoryID} and product.deleted = 1")
    Integer selectCountOfDTO(Integer categoryI);

    @Select("select product_id, product_name, product_title, product_intro, product_price, product_selling_price, product_num, product_sales, product_picture, c.category_id from product\n" +
            "    join category c on product.category_id = c.category_id\n" +
            "    where product.deleted = 1" +
            "    limit ${currentPage}, ${pageSize}")
    List<ProductDTO> selectAllListOfDTO(Integer currentPage, Integer pageSize);

    @Select("select count(*) from product\n" +
            "    join category c on product.category_id = c.category_id" +
            "    where product.deleted = 1")
    Integer selectAllTotalOfDTO();

    @Select("select product_id, product_name, product_title, product_intro, product_price, product_selling_price, product_num, product_sales, product_picture, c.category_id from product\n" +
            "    join category c on product.category_id = c.category_id\n" +
            "    where c.category_id = ${categoryID} and product.deleted = 1\n" +
            "    order by product_sales desc\n" +
            "    limit ${currentPage}, ${pageSize}")
    List<ProductDTO> selectListByHotProduct(Integer categoryID, int currentPage, int pageSize);

    @Select("select product_id, product_name, product_title, product_intro, product_price, product_selling_price, product_num, product_sales, product_picture, category_id from product\n" +
            "    where product_name like concat('%', '${keyWord}', '%') and deleted = 1\n" +
            "    limit ${currentPage}, ${pageSize}")
    List<ProductDTO> selectListProductBySearch(String keyWord, Integer currentPage, Integer pageSize);

    @Select("select count(*) from product\n" +
            "    where product_name like concat('%', '${keyWord}', '%') and deleted = 1")
    Integer selectTotalProductBySearch(String keyWord);

    @Update("update product\n" +
            "    set product_num = product_num - ${productNum}\n" +
            "    where product_id = ${productId} and deleted = 1")
    void updateById(Integer productId, Integer productNum);

    @Update("UPDATE product SET product_sales = product_sales - 1, product_num = product_num - 1 WHERE product_id = #{productId} and deleted = 1")
    void updateProduct(Integer productId);
}