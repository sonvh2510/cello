<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:output method="html" indent="yes" />

	<xsl:template match="/">

		<div class="cart-toggle item">
			<a href="javascript:void(0)">
				<figure>
					<div class="icon">
						<img src="/Data/Sites/1/skins/default/img/home/icon-4.png" alt=""></img>
					</div>
					<figcaption>
						<p>
							<xsl:value-of select="/ShoppingCart/CartText" disable-output-escaping="yes"></xsl:value-of>
							(<span class="amount">
								<xsl:value-of select="/ShoppingCart/TotalProducts" disable-output-escaping="yes">
								</xsl:value-of>
							</span>)
						</p>
					</figcaption>
				</figure>
			</a>
		</div>
		<div class="cartpanel">
			<div class="title">
				<xsl:value-of select="/ShoppingCart/CartSummaryText" disable-output-escaping="yes"></xsl:value-of>
			</div>
			<div class="btn-closecart">
				<span class="lnr lnr-cross"></span>
			</div>
			<xsl:if test="count(/ShoppingCart/CartItem)>0">
				<div class="cart-list">
					<ul>
						<xsl:apply-templates select="/ShoppingCart/CartItem"></xsl:apply-templates>
					</ul>
				</div>
				<div class="checkout-panel">
					<div class="total">
						<xsl:value-of select="/ShoppingCart/SubTotalText"></xsl:value-of>
						<xsl:text>: </xsl:text>
						<strong>
							<xsl:value-of select="/ShoppingCart/Total"></xsl:value-of>
						</strong>
					</div>
					<div class="button">
						<a class="btn-checkout">
							<xsl:attribute name="href">
								<xsl:value-of select="/ShoppingCart/CartPageUrl"></xsl:value-of>
							</xsl:attribute>
							<xsl:value-of select="/ShoppingCart/CheckoutProcessText"></xsl:value-of>
							<!-- Giỏ Hàng -->
						</a>
					</div>
				</div>
			</xsl:if>
		</div>
		<script>
			$('body').on('click', '.cart-toggle.item', function () {
				$('.cartpanel').toggleClass('open')
			})
			$('body').on('click', '.btn-closecart, main, footer', function () {
				$('.cartpanel').removeClass('open')
			})
		</script>
	</xsl:template>

	<xsl:template match="CartItem" mode="LastAddedItem">
		<xsl:if test="LastAddedItem='true'">
			<div class="productAddedToCartWindowImage">
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="Url"></xsl:value-of>
					</xsl:attribute>
					<xsl:attribute name="target">
						<xsl:value-of select="Target"></xsl:value-of>
					</xsl:attribute>
					<xsl:attribute name="title">
						<xsl:value-of select="Title"></xsl:value-of>
					</xsl:attribute>
					<img>
					<xsl:attribute name="src">
						<xsl:value-of select="ImageUrl"></xsl:value-of>
					</xsl:attribute>
					<xsl:attribute name="alt">
						<xsl:value-of select="Title"></xsl:value-of>
					</xsl:attribute>
					</img>
				</a>
				<h3>
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="Url"></xsl:value-of>
						</xsl:attribute>
						<xsl:attribute name="target">
							<xsl:value-of select="Target"></xsl:value-of>
						</xsl:attribute>
						<xsl:value-of select="Title"></xsl:value-of>
					</a>
				</h3>
			</div>
			<div class="productAddedToCartWindowDescription">
				<xsl:apply-templates select="Attributes"></xsl:apply-templates>
				<div class="briefContent">
					<xsl:value-of select="BriefContent" disable-output-escaping="yes"></xsl:value-of>
					<div>
						<strong class="price">
							<xsl:value-of select="Price"></xsl:value-of>
						</strong>
					</div>
				</div>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="CartItem">
		<li>
			<xsl:if test="ThumbnailUrl != ''">
				<a class="product-img">
					<xsl:attribute name="href">
						<xsl:value-of select="Url"></xsl:value-of>
					</xsl:attribute>
					<xsl:attribute name="target">
						<xsl:value-of select="Target"></xsl:value-of>
					</xsl:attribute>
					<xsl:attribute name="title">
						<xsl:value-of select="Title"></xsl:value-of>
					</xsl:attribute>
					<img class="img-fluid">
					<xsl:attribute name="src">
						<xsl:value-of select="ThumbnailUrl"></xsl:value-of>
					</xsl:attribute>
					<xsl:attribute name="alt">
						<xsl:value-of select="Title"></xsl:value-of>
					</xsl:attribute>
					</img>
				</a>
			</xsl:if>
			<div class="product-info">
				<h3 class="product-name">
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="Url"></xsl:value-of>
						</xsl:attribute>
						<xsl:attribute name="target">
							<xsl:value-of select="Target"></xsl:value-of>
						</xsl:attribute>
						<xsl:value-of select="Title"></xsl:value-of>
					</a>
				</h3>
				<xsl:apply-templates select="Attributes"></xsl:apply-templates>
				<div class="amount">
					<xsl:value-of select="Price"></xsl:value-of>
					<xsl:text> x </xsl:text>
					<xsl:value-of select="Quantity"></xsl:value-of>
				</div>
			</div>
			<div class="remove-product" onclick="AjaxCart.removefromcart(this);return false;">
				<xsl:attribute name="data-itemguid">
					<xsl:value-of select="ItemGuid"></xsl:value-of>
				</xsl:attribute>
				<i class="fa fa-trash-o" aria-hidden="true"></i>
			</div>
		</li>
	</xsl:template>

	<xsl:template match="Attributes">
		<div class="size">
			<xsl:value-of select="Title"></xsl:value-of>
			<xsl:text>: </xsl:text>
			<xsl:apply-templates select="Options"></xsl:apply-templates>
		</div>
	</xsl:template>
	<xsl:template match="Options">
		<xsl:if test="IsActive='true'">
			<xsl:value-of select="Title"></xsl:value-of>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
