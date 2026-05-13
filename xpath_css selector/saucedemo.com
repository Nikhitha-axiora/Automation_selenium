package xpath_cssSelector;

import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class saucedemo {

	public static void main(String[] args) throws InterruptedException {
		
		        WebDriver driver = new ChromeDriver();

		        driver.manage().window().maximize();

		        // =====================================================
		        // SCENARIO 1
		        // VALID LOGIN
		        // =====================================================

		        driver.get("https://www.saucedemo.com/");

		        driver.findElement(By.id("user-name"))
		                .sendKeys("standard_user");

		        driver.findElement(By.id("password"))
		                .sendKeys("secret_sauce");

		        driver.findElement(By.id("login-button"))
		                .click();

		        Thread.sleep(2000);

		        // getText()

		        String actualTitle = driver.findElement(
		                By.className("title")).getText();

		        System.out.println("Products Page Title : " + actualTitle);

		        // assertEquals()

		        Assert.assertEquals(actualTitle, "Products");

		        // isDisplayed()

		        WebElement productsLabel = driver.findElement(
		                By.className("title"));

		        Assert.assertTrue(productsLabel.isDisplayed());

		        // assertNotNull()

		        WebElement inventoryContainer = driver.findElement(
		                By.id("inventory_container"));

		        Assert.assertNotNull(inventoryContainer);

		        System.out.println("VALID LOGIN TEST PASSED");

		        // =====================================================
		        // SCENARIO 2
		        // INVALID PASSWORD
		        // =====================================================

		        driver.navigate().back();

		        Thread.sleep(2000);

		        driver.findElement(By.id("user-name")).clear();

		        driver.findElement(By.id("password")).clear();

		        driver.findElement(By.id("user-name"))
		                .sendKeys("standard_user");

		        driver.findElement(By.id("password"))
		                .sendKeys("wrong_password");

		        driver.findElement(By.id("login-button"))
		                .click();

		        Thread.sleep(2000);

		        // Verify error message

		        WebElement errorMessage1 = driver.findElement(
		                By.xpath("//h3[@data-test='error']"));

		        String actualError1 = errorMessage1.getText();

		        System.out.println(actualError1);

		        Assert.assertEquals(actualError1,
		                "Epic sadface: Username and password do not match any user in this service");

		        Assert.assertTrue(errorMessage1.isDisplayed());

		        Assert.assertNotNull(errorMessage1);

		        System.out.println("INVALID PASSWORD TEST PASSED");

		        // =====================================================
		        // SCENARIO 3
		        // EMPTY USERNAME
		        // =====================================================

		        driver.navigate().refresh();

		        Thread.sleep(2000);

		        driver.findElement(By.id("password"))
		                .sendKeys("secret_sauce");

		        driver.findElement(By.id("login-button"))
		                .click();

		        Thread.sleep(2000);

		        WebElement errorMessage2 = driver.findElement(
		                By.xpath("//h3[@data-test='error']"));

		        String actualError2 = errorMessage2.getText();

		        System.out.println(actualError2);

		        Assert.assertEquals(actualError2,
		                "Epic sadface: Username is required");

		        Assert.assertTrue(errorMessage2.isDisplayed());

		        Assert.assertNotNull(errorMessage2);

		        System.out.println("EMPTY USERNAME TEST PASSED");

		        // =====================================================
		        // SCENARIO 4
		        // EMPTY PASSWORD
		        // =====================================================

		        driver.navigate().refresh();

		        Thread.sleep(2000);

//		        driver.findElement(By.id("user-name"))
//		                .sendKeys("standard_user");
//
//		        driver.findElement(By.id("login-button"))
//		                .click();
//
//		        Thread.sleep(2000);
//
//		        WebElement errorMessage3 = driver.findElement(
//		                By.xpath("//h3[@data-test='error']"));
//
//		        String actualError3 = errorMessage3.getText();
//
//		        System.out.println(actualError3);
//
//		        Assert.assertEquals(actualError3,
//		                "Epic sadface: Password is required");
//
//		        Assert.assertTrue(errorMessage3.isDisplayed());
//
//		        Assert.assertNotNull(errorMessage3);
//
//		        System.out.println("EMPTY PASSWORD TEST PASSED");
//
//		        // =====================================================
//		        // CLOSE BROWSER
//		        // =====================================================
//
//		        Thread.sleep(3000);
//
//		        driver.quit();
//		    

	}

}
