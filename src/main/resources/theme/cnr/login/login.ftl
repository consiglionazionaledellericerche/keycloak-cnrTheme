<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
    <div id="kc-form">
      <div id="kc-form-wrapper">
        <#if realm.password>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <div class="${properties.kcFormGroupClass!}">
                    <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                    <#if usernameEditDisabled??>
                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" disabled />
                    <#else>
                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                        />

                        <#if messagesPerField.existsError('username','password')>
                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                        </#if>
                    </#if>
                </div>

                <div class="${properties.kcFormGroupClass!}">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>

                    <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="off"
                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                    />
                </div>

                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                    <div id="kc-form-options">
                        <#if realm.rememberMe && !usernameEditDisabled??>
                            <div class="checkbox">
                                <label>
                                    <#if login.rememberMe??>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                    <#else>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                    </#if>
                                </label>
                            </div>
                        </#if>
                        </div>
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <#if realm.resetPasswordAllowed>
                                <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                            </#if>
                        </div>

                  </div>

                  <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                      <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                      <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                  </div>
            </form>
        </#if>
        </div>

        <#if realm.password && social.providers??>
            <#assign spidFlag = 0>
            <#assign idemFlag = 0>
            <#list social.providers as p>
                <#if p.alias == "Aruba" || p.alias == "Infocert" || p.alias == "Intesa" || p.alias == "Lepida" || p.alias == "Namirial" || p.alias == "Poste" || p.alias == "Sielte" || p.alias == "SpidItalia" || p.alias == "Tim"><#assign spidFlag = 1></#if>
                <#if p.alias == "saml"><#assign idemFlag = 1></#if>
            </#list>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if idemFlag == 1 && spidFlag == 1>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <#if p.alias == "saml">
                        <a class="idem-button" href="${p.loginUrl}">
                            <span class="spid-sr-only">${p.displayName!}</span>
                            <img src="${url.resourcesPath}/img/idem.svg" onerror="this.src='${url.resourcesPath}/img/idem.png'; this.onerror=null;" alt="${p.displayName!}" style="height:40px; width: auto" />
                        </a>
                        </#if>
                    </#list>
                    <#if spidFlag == 1>
                    <a href="#" class="italia-it-button italia-it-button-size-m button-spid" spid-idp-button="#spid-idp-button-medium-get" aria-haspopup="true" aria-expanded="false">
                        <span class="italia-it-button-icon"><img src="${url.resourcesPath}/img/spid-ico-circle-bb.svg" onerror="this.src='${url.resourcesPath}/img/spid-ico-circle-bb.png'; this.onerror=null;" alt="" /></span>
                        <span class="italia-it-button-text">Entra con SPID</span>
                    </a>
                    </#if>
                </ul>
                <div id="spid-idp-button-medium-get" class="spid-idp-button spid-idp-button-tip spid-idp-button-relative">
                    <ul id="spid-idp-list-medium-root-get" class="spid-idp-button-menu" aria-labelledby="spid-idp">
                        <#list social.providers as p>
                            <#if p.alias == "spid">
                            <li class="spid-idp-button-link">
                                <a href="${p.loginUrl}">
                                    <span class="spid-sr-only">${p.displayName!}</span>
                                    <img src="${url.resourcesPath}/img/spid-idp-${p.alias!}.svg" onerror="this.src='${url.resourcesPath}/img/spid-idp-${p.alias!}.png'; this.onerror=null;" alt="${p.displayName!}"/>
                                </a>
                            </li>
                            </#if>
                        </#list>
                        <li class="spid-idp-support-link" data-spidlink="info">
                            <a href="https://www.spid.gov.it">Maggiori informazioni</a>
                        </li>
                        <li class="spid-idp-support-link" data-spidlink="rich">
                            <a href="https://www.spid.gov.it/richiedi-spid">Non hai SPID?</a>
                        </li>
                        <li class="spid-idp-support-link" data-spidlink="help">
                            <a href="https://www.spid.gov.it/serve-aiuto">Serve aiuto?</a>
                        </li>
                    </ul>
                </div>
                <#list social.providers as p>
                    <#if p.alias == "cieid">
                        <a class="cie-button" href="${p.loginUrl}">
                            <span class="spid-sr-only">${p.displayName!}</span>
                            <img src="${url.resourcesPath}/img/cie.png" onerror="this.src='${url.resourcesPath}/img/cie.png'; this.onerror=null;" alt="${p.displayName!}" style="height:40px; width: auto" />
                        </a>
                    </#if>
                </#list>
            </div>
        </#if>

    </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>