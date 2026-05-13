package day1;

import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.WebDriver;
public class saucedemo {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		WebDriver driver = new ChromeDriver();

        try {
            driver.get("https://www.saucedemo.com");

            // Print Details
            System.out.println("Title: " + driver.getTitle());
            System.out.println("URL: " + driver.getCurrentUrl());
            System.out.println("Source Length: " + driver.getPageSource().length());

//            // Screenshot
//            File src = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
//            File dest = new File("saucedemo_screenshot.png");
//            Files.(src.toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
//            
            System.out.println("Screenshot saved successfully.");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit();
        }
    }


}
